#!/bin/bash
while getopts "he:d:" opt; do
  case $opt in
    h) echo "Usage: list subdirs by size"; exit 0;;
    e) ERR="$OPTARG";;
    d) DIR="$OPTARG";;
  esac
done
: ${DIR:=$(pwd)}
: ${ERR:=/dev/stderr}
for d in "$DIR"/*; do
    [[ -d "$d" ]] || continue
    size=$(find "$d" -type f -printf '%s\n' | awk '{s+=$1} END{print s+0}')
    echo "$size $d"
done | sort -n 2>>"$ERR"
