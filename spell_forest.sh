#!/bin/sh
echo -ne '\033c\033]0;ldjam51\a'
base_path="$(dirname "$(realpath "$0")")"
"$base_path/spell_forest.x86_64" "$@"
