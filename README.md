# impacket-creds2ccache
impacket-creds2ccache can iterate over a colon-delimited list of username:password:hash and generate ccache files, using impacket-getTGT.  Password is preferred over hash.

### Usage
```
USAGE: /home/notroot/bin/impacket-credfile2ccaches.sh 
    -c|--credfile <credfile>  : credfile, username:password:hash format
                                password and hash are optional, delims are
                                not
    -d|--domain <domainfqdn>  : domain in IP or fqdn format
    -D|--dc <dc_ip_or_host>   : dc ip/hostname in fqdn format
    -h|--help                 : this help
```

### Example creds file
Remember, password will be preferred over hash, if both available
```
marsupial_rage:LBMgEWaKUnBG:
gamboye_boi::381b793bde4dea233ae34bb1d9ce38f5
goat_sucker_da:C@ntTr1pl3st4mp4d0ub13st4mp!:
sarajevo_warrior:g1mm3m0r34rr0ws!2:
jeremy_spoken:w3un134sh3d4L10n:4b4ed5dfaa22dc4e41c279c0c62b9ee2
fabrizio_arcane::e80b666e0ee68cd0a6516a92e75231cc
kunta_kinte::7c8fed15e80ed63db789ad740cda2f18
cramped_forehead:S1mm3rd0wnSyndr0me89!$:
keyser_soze:3mp0r3rKuj4nt0ol3g1t%:
yomamas_momma::be1ce1381c084dc4cda8159a665b3c59
```

### Example in action
```
┌──(notroot㉿elysium)-[~/engagement/chupacabra]
└─$ impacket-creds2ccaches.sh --domain chupacabra.local --dc dc4.chupacabra.local --credfile creds.txt 
[*] Saving ticket in goat_sucker_da.ccache
[*] Saving ticket in jeremy_spoken.ccache
[*] Saving ticket in kunta_kinte.ccache
[*] Saving ticket in keyser_soze.ccache
```
