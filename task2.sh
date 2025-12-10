#!/bin/bash
while getopts "he:" opt; do
  case $opt in
    h) echo "Usage: count lines in files"; exit 0;;
    e) ERR="$OPTARG";;
  esac
done
: ${ERR:=/dev/stderr}
shift $((OPTIND-1))
wc -l "$@" | tail -n1 2>>"$ERR"
