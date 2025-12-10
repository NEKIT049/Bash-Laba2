#!/bin/bash
signal=15
while getopts "he:s:" opt; do
  case $opt in
    h) echo "Usage: killall clone"; exit 0;;
    e) ERR="$OPTARG";;
    s) signal="$OPTARG";;
  esac
done
: ${ERR:=/dev/stderr}
shift $((OPTIND-1))
name="$1"
pids=$(pgrep "$name")
for p in $pids; do kill -"$signal" "$p"; done 2>>"$ERR"
