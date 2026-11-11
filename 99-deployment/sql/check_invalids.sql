-- Poziv: @99-deployment/sql/check_invalids.sql <SCHEMA>
-- Izvrsava se poslije deploymenta i rekompajliranja svih ciljnih shema.
whenever sqlerror exit failure rollback
whenever oserror exit failure rollback
set echo off
set verify off
set serveroutput on size unlimited

declare
  l_schema       varchar2(128) := dbms_assert.schema_name(upper('&1'));
  l_objects_view varchar2(30) := 'all_objects';
  l_errors_view  varchar2(30) := 'all_errors';
  l_invalids     pls_integer;
  l_rows         sys_refcursor;
  l_name         varchar2(128);
  l_type         varchar2(128);
  l_status       varchar2(7);
  l_line         pls_integer;
  l_position     pls_integer;
  l_text         varchar2(4000);
begin
  -- Za drugog vlasnika potreban je potpun uvid u metapodatke sheme.
  if sys_context('USERENV', 'SESSION_USER') <> l_schema then
    l_objects_view := 'sys.dba_objects';
    l_errors_view := 'sys.dba_errors';
  end if;

  execute immediate
    'select count(*) from ' || l_objects_view ||
    ' where owner = :owner and status <> ''VALID'''
    into l_invalids using l_schema;

  dbms_output.put_line('Shema ' || l_schema || ': nevalidnih objekata = ' || l_invalids);

  if l_invalids > 0 then
    open l_rows for
      'select object_name, object_type, status from ' || l_objects_view ||
      ' where owner = :owner and status <> ''VALID''' ||
      ' order by object_type, object_name'
      using l_schema;

    loop
      fetch l_rows into l_name, l_type, l_status;
      exit when l_rows%notfound;
      dbms_output.put_line(l_schema || '.' || l_name || ' [' || l_type || '] ' || l_status);
    end loop;
    close l_rows;

    open l_rows for
      'select name, type, line, position, text from ' || l_errors_view ||
      ' where owner = :owner and attribute = ''ERROR''' ||
      ' order by name, type, sequence'
      using l_schema;

    loop
      fetch l_rows into l_name, l_type, l_line, l_position, l_text;
      exit when l_rows%notfound;
      dbms_output.put_line(l_schema || '.' || l_name || ' [' || l_type || '] ' ||
                           l_line || ':' || l_position || ' ' || l_text);
    end loop;
    close l_rows;

    raise_application_error(-20001, 'Shema ' || l_schema ||
                            ' ima ' || l_invalids || ' nevalidnih objekata.');
  end if;

  dbms_output.put_line('OK: CHECK: ' || l_schema);
end;
/

undefine 1
exit success rollback
