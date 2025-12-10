#!/bin/bash
outdir="$(pwd)"
stype=hard
while getopts "he:d:o:s" opt; do
  case $opt in
    h) echo "Usage: find string and link"; exit 0;;
    e) ERR="$OPTARG";;
    d) DIR="$OPTARG";;
    o) outdir="$OPTARG";;
    s) stype=soft;;
  esac
done
shift $((OPTIND-1))
pattern="$1"
: ${DIR:=$(pwd)}
: ${ERR:=/dev/stderr}
find "$DIR" -type f | while read f; do
    if grep -q "$pattern" "$f"; then
        base=$(basename "$f")
        [[ $stype == hard ]] && ln "$f" "$outdir/$base" || ln -s "$f" "$outdir/$base"
    fi
done 2>>"$ERR"
