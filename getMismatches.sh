#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=4:00:00,mem=4G
#
echo BEGIN `date`
bam=$1
mis=`basename $bam .bam`_mismatch
samtools view $bam | awk '{for(i=1;i<=NF;i++) if($i~/NM:/){Mis[$i]++}}END{for(mis in Mis){print mis"\t"Mis[mis] > "'$mis'.tmp"}}'
cat $mis.tmp  | sed 's/:i:/\t/g' | sort -k2,2 -n | awk 'NR<=10{print $1$2"\t"$3 > "'$mis'.txt"}; NR>10{gt10+=$3}END{print "NMgt10\t"gt10 >> "'$mis'.txt"}'
rm $mis.tmp
echo mismatches count for `basename $bam .bam` COMPLETED `date`
