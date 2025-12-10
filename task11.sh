#!/bin/bash
dperm="0644"
duser="$USER"
dgroup="$(id -gn)"
setperm=""
setuser=""
setgroup=""
while getopts "he:m:M:u:U:g:G:" opt; do
  case $opt in
    h) echo "Usage: create files from config"; exit 0;;
    e) ERR="$OPTARG";;
    m) dperm="$OPTARG";;
    M) setperm="$OPTARG";;
    u) duser="$OPTARG";;
    U) setuser="$OPTARG";;
    g) dgroup="$OPTARG";;
    G) setgroup="$OPTARG";;
  esac
done
shift $((OPTIND-1))
: ${ERR:=/dev/stderr}
conf="$1"
while IFS=":" read path perm user group; do
    path=$(echo "$path"|xargs)
    [[ -z "$path" ]] && continue
    perm=$(echo "${perm:-$dperm}"|xargs)
    user=$(echo "${user:-$duser}"|xargs)
    group=$(echo "${group:-$dgroup}"|xargs)
    [[ -n "$setperm" ]] && perm="$setperm"
    [[ -n "$setuser" ]] && user="$setuser"
    [[ -n "$setgroup" ]] && group="$setgroup"
    mkdir -p "$(dirname "$path")"
    touch "$path"
    chmod "$perm" "$path"
    chown "$user:$group" "$path"
done < "$conf" 2>>"$ERR"
