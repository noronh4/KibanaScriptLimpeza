#!/bin/bash

sudo curl -X GET "xx.xx.xx.xx:9200/_cat/indices?v=true&s=store.size:desc" > get-index.txt


MES=$(date "+%m")
MES=${MES#0}
#echo $(declare -p MES)
DIFF_DATE=0


for i in $(grep -noE "[0-9]{2}.2022" get-index.txt | tr ":" "." ); do
    MES_INDEX=$(echo $i | awk 'BEGIN { FS = "." } ; { print $2 }')
    MES_INDEX=${MES_INDEX#0}
    LINHA=$(echo $i | awk 'BEGIN { FS = "." } ; { print $1 }')
    DIFF_DATE=$(echo $(( $MES - $MES_INDEX )))
    
	if [ $DIFF_DATE != 0 ]
	then
		INDEX_VELHO=$(echo $(sed -n ${LINHA}p get-index.txt | awk '{print $3}'))
        	#echo $INDEX_VELHO
       		curl -X DELETE "xx.xx.xx.xx:9200/$INDEX_VELHO?pretty"
		#echo =================
	fi
