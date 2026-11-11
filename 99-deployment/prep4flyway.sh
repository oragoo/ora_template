#!/usr/bin/env bash
set -euo pipefail
set +x

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <temporary-database-copy>" >&2
  exit 2
fi

working_dir="$1"
if [[ ! -d "$working_dir" ]]; then
  echo "Database copy does not exist: $working_dir" >&2
  exit 2
fi

working_dir="$(cd "$working_dir" && pwd)"
echo "Preparing Flyway files in: $working_dir"

# Ovaj folder je eksplicitno izuzet iz deploymenta i uklanja se samo iz
# privremene kopije koju je pozivalac proslijedio skripti.
if [[ -d "$working_dir/00-no-install" ]]; then
  rm -rf -- "$working_dir/00-no-install"
fi

while IFS= read -r -d '' subfolder; do
  folder_name="$(basename "$subfolder")"
  if [[ ! "$folder_name" =~ ^[0-9]{2}- ]]; then
    echo "Skipping folder without numeric prefix: $folder_name"
    continue
  fi

  folder_prefix="${folder_name:0:2}"

  while IFS= read -r -d '' source_file; do
    file_name="$(basename "$source_file")"

    case "$file_name" in
      .gitkeep|README|README.md|readme.md)
        continue
        ;;
    esac

    if [[ "$file_name" =~ ^V[0-9]+__.+\.sql$ ]]; then
      continue
    fi

    if [[ ! "$file_name" =~ ^R__.+\.[A-Za-z0-9]+$ ]]; then
      echo "Skipping file outside R/V convention: $folder_name/$file_name"
      continue
    fi

    stem="${file_name%.*}"
    extension="${file_name##*.}"
    extension="${extension,,}"
    description="${stem#R__}"

    case "$extension" in
      spc|tps|pks)
        suffix="_01_${extension}"
        ;;
      bdy|tpb|pkb)
        suffix="_02_${extension}"
        ;;
      sql)
        suffix=""
        ;;
      prc|fnc|trg)
        suffix="_${extension}"
        ;;
      *)
        echo "Unsupported repeatable extension: $folder_name/$file_name" >&2
        exit 3
        ;;
    esac

    description="${description//-/_}"
    target_file="$subfolder/R__${folder_prefix}_${description}${suffix}.sql"
    if [[ "$source_file" == "$target_file" ]]; then
      continue
    fi
    if [[ -e "$target_file" ]]; then
      echo "Refusing to overwrite existing file: $target_file" >&2
      exit 4
    fi

    mv -- "$source_file" "$target_file"
    echo "$folder_name/$file_name -> $(basename "$target_file")"
  done < <(find "$subfolder" -mindepth 1 -maxdepth 1 -type f -print0)
done < <(find "$working_dir" -mindepth 1 -maxdepth 1 -type d -print0)

echo "Flyway preparation completed."
