#!/bin/sh

LEAGUE_ID=$1

REMAINING=1
MIN_ID=0
while [[ $REMAINING -gt 0 ]]
do
    rm -f match_history.txt
    wget -O match_history.txt 'https://api.steampowered.com/IDOTA2Match_570/GetMatchHistory/v001/?key=DE2A619FF470C60499CF226048861466&league_id='$LEAGUE_ID'&start_at_match_id='$MIN_ID
    MIN_ID=$(cat match_history.txt | grep match_id | sed 's/.*://g' | sed 's/,//g' | sort | head -n 1)
    REMAINING=$(cat match_history.txt | grep results_remaining | sed 's/.*://g' | sed 's/,//g')
    cat match_history.txt | grep match_id | sed 's/.*://g' | sed 's/,//g' | sort >> match_id.tmp
done

cat match_id.tmp | sort | uniq > match_id.txt
rm -f match_id.tmp match_history.txt
