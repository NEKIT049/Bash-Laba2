#!/bin/bash
outfile=".install-config"
auto=false
dpath="$HOME"
dperm="0644"
duser="$USER"
dgroup="$(id -gn)"
while getopts "he:o:ap:m:u:g:" opt; do
  case $opt in
    h) echo "Usage: interactive config builder"; exit 0;;
    e) ERR="$OPTARG";;
    o) outfile="$OPTARG";;
    a) auto=true;;
    p) dpath="$OPTARG";;
    m) dperm="$OPTARG";;
    u) duser="$OPTARG";;
    g) dgroup="$OPTARG";;
  esac
done
shift $((OPTIND-1))
DIR="$1"
for f in "$DIR"/*; do
    [[ -f "$f" ]] || continue
    if $auto; then
        echo "$f : $dperm : $duser : $dgroup" >> "$outfile"
    else
        echo "$f : $dperm : $duser : $dgroup" >> "$outfile"
    fi
done 2>>"$ERR"
