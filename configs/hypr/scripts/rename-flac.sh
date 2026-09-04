#!/usr/bin/env bash
# rename-flac.sh
# Recursively renames .flac files to "Title - Artist.flac" using metadata tags.
# Strips leading track numbers from filenames for files missing metadata.
#
# Usage:
#   ./rename-flac.sh [directory]              # dry run
#   ./rename-flac.sh [directory] --apply       # actually rename

set -uo pipefail

DIR="."
APPLY=false

for arg in "$@"; do
    case "$arg" in
        --apply) APPLY=true ;;
        *) DIR="$arg" ;;
    esac
done

if ! command -v metaflac &>/dev/null; then
    echo "metaflac not found. Install with: sudo pacman -S flac" >&2
    exit 1
fi

if [[ ! -d "$DIR" ]]; then
    echo "Not a directory: $DIR" >&2
    exit 1
fi

if [[ "$APPLY" == false ]]; then
    echo "== DRY RUN — no files renamed. Re-run with --apply to actually rename. =="
fi

sanitize() {
    printf '%s' "$1" | sed 's#/# #g; s#[\\:*?"<>|]##g' | sed 's/[[:space:]]\+/ /g' | sed 's/^ *//;s/ *$//'
}

strip_tracknum() {
    printf '%s' "$1" | sed -E 's/^[0-9]+\s+[-–.—]\s+//' | sed -E 's/^[0-9]+\s+//' | sed -E 's/^[0-9]+[-–.—]//' | sed -E 's/^[[:space:]]+//'
}

count_renamed=0
count_skipped=0

while IFS= read -r -d '' file; do
    dir_path=$(dirname -- "$file")
    old_name=$(basename -- "$file")
    ext=".flac"

    title=$(metaflac --show-tag=TITLE "$file" 2>/dev/null | grep -im1 '^TITLE=' | sed 's/^[Tt][Ii][Tt][Ll][Ee]=//')
    artist=$(metaflac --show-tag=ARTIST "$file" 2>/dev/null | grep -im1 '^ARTIST=' | sed 's/^[Aa][Rr][Tt][Ii][Ss][Tt]=//')

    if [[ -n "$title" && -n "$artist" ]]; then
        clean_title=$(sanitize "$title")
        clean_artist=$(sanitize "$artist")
        if [[ -z "$clean_title" || -z "$clean_artist" ]]; then
            echo "SKIP (empty metadata after sanitizing): $file"
            ((count_skipped++))
            continue
        fi
        new_name="$clean_title - $clean_artist.flac"
    elif [[ -n "$title" ]]; then
        clean_title=$(sanitize "$title")
        if [[ -z "$clean_title" ]]; then
            echo "SKIP (empty title after sanitizing): $file"
            ((count_skipped++))
            continue
        fi
        new_name="$clean_title.flac"
    else
        # Fallback: strip leading track numbers from filename
        stripped=$(strip_tracknum "$old_name")
        if [[ "$stripped" == "$old_name" ]]; then
            echo "SKIP (no metadata, no tracknum to strip): $file"
            ((count_skipped++))
            continue
        fi
        new_name="$stripped"
    fi

    if [[ "$old_name" == "$new_name" ]]; then
        continue
    fi

    new_path="$dir_path/$new_name"

    n=1
    while [[ -e "$new_path" ]]; do
        base="${new_name%.flac}"
        new_path="$dir_path/$base ($n).flac"
        n=$((n + 1))
    done

    if [[ "$APPLY" == true ]]; then
        mv -n -- "$file" "$new_path"
        echo "RENAMED: $old_name -> $(basename "$new_path")"
    else
        echo "WOULD RENAME: $old_name -> $(basename "$new_path")"
    fi
    ((count_renamed++))
done < <(find "$DIR" -type f -iname "*.flac" -print0)

echo
echo "Done. $count_renamed renamed/would-rename, $count_skipped skipped."
