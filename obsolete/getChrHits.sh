#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=4:00:00,mem=4G
#
echo BEGIN `date`
bam=$1
chrHits=`basename $bam .bam`_chrHits.txt
samtools index $bam
samtools idxstats $bam | cut -f1,3 | grep chr > $chrHits
echo chromosome count `basename $bam .bam` COMPLETED `date`
