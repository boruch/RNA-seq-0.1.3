#!/bin/bash
#$ -V
#$ -cwd
#$ -l h_data=6G
#
echo BEGIN sam2bam3 `date`
bam=$1
#
samtools sort $bam `basename $bam .bam`.sorted
#rm $bam
echo COMPLETE sam2bam3 `date`
#end_script
