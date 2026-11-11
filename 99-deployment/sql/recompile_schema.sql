-- Poziv: @99-deployment/sql/recompile_schema.sql <SCHEMA>
-- Rekompajlirati sve ciljne sheme prije zavrsne provjere bilo koje sheme.
whenever sqlerror exit failure rollback
whenever oserror exit failure rollback
set echo off
set verify off
set serveroutput on size unlimited

declare
  l_schema varchar2(128) := dbms_assert.schema_name(upper('&1'));
begin
  dbms_output.put_line('Rekompajliranje nevalidnih objekata: ' || l_schema);

  dbms_utility.compile_schema(
    schema         => l_schema,
    compile_all    => false,
    reuse_settings => true
  );

  dbms_output.put_line('OK: RECOMPILE: ' || l_schema);
end;
/

undefine 1
exit success rollback
