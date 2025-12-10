#!/bin/bash
while getopts "he:" opt; do
  case $opt in
    h) echo "Usage: prints power table"; exit 0;;
    e) ERR="$OPTARG";;
  esac
done
: ${ERR:=/dev/stderr}

for n in {1..9}; do
    row=""
    for p in {0..6}; do
        row+="$((n**p)) "
    done
    echo "$row"
done 2>>"$ERR"
