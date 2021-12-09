#!/bin/bash

db="nba_stats.sqlite"
rm -f ${db}
touch ${db}

#runs the data base: 
sqlite3 ${db} < "project_nba.sql"

#if you get a bad interpreter error:
#run:
#sed -i -e 's/\r$//' scriptname.sh

#then:
#./test.sh