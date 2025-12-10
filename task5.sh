#!/bin/bash
while getopts "he:" opt; do
  case $opt in
    h) echo "Usage: dirs... threshold"; exit 0;;
    e) ERR="$OPTARG";;
  esac
done
shift $((OPTIND-1))
: ${ERR:=/dev/stderr}
THRESH="${!#}"
dirs = sys.argv[1:-1]
import subprocess, os
for d in dirs:
    for root,_,files in os.walk(d):
        for file in files:
            path=os.path.join(root,file)
            try:
                with open(path) as f:
                    wc=len(f.read().split())
                if wc>int(THRESH):
                    print(os.path.relpath(path))
            except: pass
