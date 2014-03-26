#!/bin/bash
#$ -V
#$ -cwd
#
sam=$1
#
samtools view -Sb $sam > temp.bam
samtools sort temp.bam sorted
rm temp.bam 
#end_script
