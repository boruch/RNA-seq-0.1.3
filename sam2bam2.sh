#!/bin/bash
#$ -V
#$ -cwd
#$ -l h_data=6G
#
echo BEGIN sam2bam2 `date`
sam=$1
#
samtools view -Sb $sam > `basename $sam .sam`.bam
rm $sam
echo COMPLETE sam2bam2 `date`
#end_script
