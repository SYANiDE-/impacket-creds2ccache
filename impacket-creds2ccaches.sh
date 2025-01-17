#!/bin/bash
TEMP=$(getopt -o h --long help,credfile:,domain:,dc: -n "javawrap" -- "$@")
if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
eval set -- "$TEMP"

IFS='' read -r -d '' HELP <<EOF
Helper script that uses impacket-getTGT to generate ccache files based on a provided credentials file in the format <username:password:hash>, where password OR hash are optional, password preferred over hash.

USAGE: $0 
    -c|--credfile <credfile>  : credfile, username:password:hash format
                                password OR hash are optional, delims are
                                not
    -d|--domain <domainfqdn>  : domain in IP or fqdn format
    -D|--dc <dc_ip_or_host>   : dc ip/hostname in fqdn format
    -h|--help                 : this help
EOF

while true; do
    case "$1" in
        -c | --credfile ) credfile="$2"; shift 2 ;;
        -d | --domain ) domain="$2"; shift 2 ;;
        -D | --dc ) dcip="$2"; shift 2 ;; 
        -h | --help ) for item in "${HELP[@]}"; do echo -e "$item"; done; exit ;; 
        *) break ;;
    esac
done

for item in $(cat $credfile); do 
    username=$(cut -d ':' -f 1 <<<$item); 
    password=":$(cut -d ':' -f 2 <<<$item)";
    hash="" 
    if [[ $(grep -Po ":" <<<$item | wc -c) -eq 2 ]] && [[ ${#password} -eq 0 ]]; then 
        hash="-hashes :$(cut -d ':' -f 3 <<<$item)";
    fi
    impacket-getTGT $hash $domain/$username$password -dc-ip $dcip | grep -i "saving" 
done