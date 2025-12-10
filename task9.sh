#!/bin/bash
while getopts "he:" opt; do
  case $opt in
    h) echo "Usage: remove files from list"; exit 0;;
    e) ERR="$OPTARG";;
  esac
done
shift $((OPTIND-1))
: ${ERR:=/dev/stderr}
list="$1"
while read f; do rm -f "$f"; done < "$list" 2>>"$ERR"
