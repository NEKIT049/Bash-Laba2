#!/bin/bash
remove=false
while getopts "hre:" opt; do
  case $opt in
    h) echo "Usage: create/remove hardlinks"; exit 0;;
    r) remove=true;;
    e) ERR="$OPTARG";;
  esac
done
shift $((OPTIND-1))
: ${ERR:=/dev/stderr}
for f in "$@"; do
    if $remove; then
        for n in {1..9}; do rm -f "${f}.${n}"; done
    else
        for n in {1..9}; do
            l="${f}.${n}"
            if [[ ! -e "$l" ]]; then ln "$f" "$l"; break; fi
        done
    fi
done 2>>"$ERR"
