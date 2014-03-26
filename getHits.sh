#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=6:30:00,mem=4G
#
echo BEGIN `date`
sam=$1
hits=`basename $sam .sam`_hits
samtools view -S $sam | awk '{for(i=1;i<=NF;i++){if($i~/NH:i:/){Hits[$i]++}}}END{for(hit in Hits){print hit"\t"Hits[hit]/1000000 > "'$hits'.tmp"}}'
cat $hits.tmp | sed 's/:i:/\t/g' | sort -k2,2 -n | awk 'NR<=10{print $1$2"\t"$3 > "'$hits'.txt"}; NR>10{gt10+=$3}END{print "NHgt10\t"gt10 >> "'$hits'.txt"}'
rm $hits.tmp
echo `basename $sam .sam` COMPLETED `date`
