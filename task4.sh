#!/bin/bash
while getopts "he:d:" opt; do
  case $opt in
    h) echo "Usage: find dirs containing file"; exit 0;;
    e) ERR="$OPTARG";;
    d) DIR="$OPTARG";;
  esac
done
: ${ERR:=/dev/stderr}
shift $((OPTIND-1))
NAME="$1"
: ${DIR:=$(pwd)}
find "$DIR" -type f -name "$NAME" -printf '%h\n' | sort -u 2>>"$ERR"
