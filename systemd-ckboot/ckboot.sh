. /etc/ckboot.conf

if [[ -e /tmp/ckboot ]]
then
    msgmbr="- The MBR and/or the following blocks have changed\n"
    msgfiles="- Files have been changed, added or removed in /boot\n"
    msghash="No hash files could be found.\nUse ckboot-init to inicialize the hashes."
    msgchange="Use ckboot-init to reinicialize the hashes if changes were expected\n\otherwise you may have been the victim of an attack."
    
    errhash="x$(grep hash /tmp/ckboot)"
    errmbr="x$(grep mbr /tmp/ckboot)"
    errfiles="x$(grep files /tmp/ckboot)"
    
    [[ "$errhash" == "xhash" ]] && zmsg="$zmsg$msghash"
    [[ "$errmbr" == "xmbr" ]] && zmsg="$zmsg$msgmbr"
    [[ "$errfiles" == "xfiles" ]] && zmsg="$zmsg$msgfiles"
    
    [[ "$errmbr" == "xmbr" || "$errfiles" == "xfiles" ]] && zmsg="$zmsg\n$msgchange"
else
    zmsg="Something is wrong, cannot find the verification results file."
fi

if [[ -n "$zmsg" ]]
then
    zmsg="\n########  WARNING:ckboot  ########\n$zmsg"
    /bin/echo -e "$zmsg"
fi
