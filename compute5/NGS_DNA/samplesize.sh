HEADER=$(head -1 $1)
IFS=', ' read -r -a array <<< $HEADER
count=0
DIR=$2
for i in "${array[@]}"
do
  	if [ "${array[count]}" == "externalSampleID" ]
        then
            	awk '{FS=","}{print $'$count'}' $1 > $DIR/countRows.txt
        fi
	count=$((count + 1))
done

cat $DIR/countRows.txt | uniq | wc -l
rm $DIR/countRows.txt
