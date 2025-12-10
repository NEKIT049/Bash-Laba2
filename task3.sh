#!/bin/bash
while getopts "he:d:" opt; do
  case $opt in
    h) echo "Usage: count files"; exit 0;;
    e) ERR="$OPTARG";;
    d) DIR="$OPTARG";;
  esac
done
: ${ERR:=/dev/stderr}
: ${DIR:=$(pwd)}
find "$DIR" -type f | wc -l 2>>"$ERR"
