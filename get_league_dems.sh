#!/bin/sh

rm -f match_dems
for MATCH_ID in `cat match_id `
do
    wget -O match_detail.tmp 'http://104.218.234.46/?match_id='$MATCH_ID > /dev/null 2>&1
    SALT=$(grep replay_salt match_detail.tmp | sed 's/.*replay_salt"://g' | sed 's/,.*//g')
    CLUSTER=$(grep cluster match_detail.tmp | sed 's/.*cluster"://g' | sed 's/,.*//g')
    echo 'http://replay'$CLUSTER'.valve.net/570/'$MATCH_ID'_'$SALT'.dem.bz2' >> match_dems
    rm -f match_detail.tmp
done
