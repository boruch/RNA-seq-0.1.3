#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=4:00:00,mem=4G
#
echo BEGIN `date`
bam=$1
chrHits=`basename $bam .bam`_chrHits.txt
echo -e chrom'\t'`dirname $bam | xargs -I{} basename {}` > $chrHits
samtools index $bam
samtools idxstats $bam | cut -f1,3 | grep -v "_" | grep chr | awk '{print $1"\t"$2/1000000}' >> $chrHits
echo chromosome count `basename $bam .bam` COMPLETED `date`
