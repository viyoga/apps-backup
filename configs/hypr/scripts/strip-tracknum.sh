#!/usr/bin/env bash
# strip-tracknum.sh
# Recursively strips leading track numbers from .flac filenames.
# E.g. "06 Sad Girl.flac" -> "Sad Girl.flac"
#       "01 - Olivia Rodrigo - All I Want.flac" -> "Olivia Rodrigo - All I Want.flac"
#
# Usage:
#   ./strip-tracknum.sh [directory]              # dry run
#   ./strip-tracknum.sh [directory] --apply       # actually rename

set -uo pipefail

DIR="."
APPLY=false

for arg in "$@"; do
    case "$arg" in
        --apply) APPLY=true ;;
        *) DIR="$arg" ;;
    esac
done

if [[ ! -d "$DIR" ]]; then
    echo "Not a directory: $DIR" >&2
    exit 1
fi

if [[ "$APPLY" == false ]]; then
    echo "== DRY RUN — no files renamed. Re-run with --apply to actually rename. =="
fi

count_renamed=0
count_skipped=0

while IFS= read -r -d '' file; do
    dir_path=$(dirname -- "$file")
    old_name=$(basename -- "$file")

    # Strip leading track number — handle various separator styles
    # 1. "01 - Name" -> "Name"    (digits + space + dash + space)
    # 2. "06 Name" -> "Name"      (digits + space)
    # 3. "2-Name" -> "Name"       (digits + dash)
    # 4. "7. Name" -> "Name"      (digits + period + space)
    # Does NOT match "347aidan" (digits attached to letters directly)
    new_name=$(printf '%s' "$old_name" | sed -E 's/^[0-9]+\s+[-–.—]\s+//' | sed -E 's/^[0-9]+\s+//' | sed -E 's/^[0-9]+[-–.—]//' | sed -E 's/^[[:space:]]+//')

    if [[ "$new_name" == "$old_name" ]]; then
        continue
    fi

    if [[ -z "$new_name" ]]; then
        echo "SKIP (empty after stripping): $file"
        ((count_skipped++))
        continue
    fi

    new_path="$dir_path/$new_name"

    if [[ -e "$new_path" ]]; then
        echo "SKIP (target exists): $file -> $new_name"
        ((count_skipped++))
        continue
    fi

    if [[ "$APPLY" == true ]]; then
        mv -n -- "$file" "$new_path"
        echo "RENAMED: $old_name -> $new_name"
    else
        echo "WOULD RENAME: $old_name -> $new_name"
    fi
    ((count_renamed++))
done < <(find "$DIR" -type f -iname "*.flac" -print0)

echo
echo "Done. $count_renamed renamed/would-rename, $count_skipped skipped."
