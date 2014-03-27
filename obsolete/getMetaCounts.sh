#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=4:00:00,mem=4G
#
echo BEGIN `date`
bam=$1
ref=$2
out=`basename $bam .bam`_counts.txt
~charlesb/BEDTools/bin/coverageBed -split -abam $bam -b $ref | awk '{A[$4]+=$7}END{for(i in A) print i"\t"A[i]}' | sort -k1,1 > $out
echo meta read count `basename $bam .bam` COMPLETED `date`
