#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=6:30:00,mem=4G
#
echo BEGIN `date`
bam=$1
hits=`basename $bam .bam`_hits
samtools view $bam | awk '{for(i=1;i<=NF;i++){if($i~/NH:i:/ || $i~/X0:i:/){Hits[$i]++} }}END{for(hit in Hits){print hit"\t"Hits[hit] > "'$hits'.tmp"}}'
cat $hits.tmp | sed 's/:i:/\t/g' | sort -k2,2 -n | awk 'NR<=10{print $1$2"\t"$3 > "'$hits'.txt"}; NR>10{gt10+=$3}END{print "NHgt10\t"gt10 >> "'$hits'.txt"}'
rm $hits.tmp
echo `basename $bam .bam` COMPLETED `date`
