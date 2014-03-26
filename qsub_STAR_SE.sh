#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 8
#$ -l h_data=4G,time=4:00:00
#$ -V		

# include full path to input
end1=$1
ref=$2

echo BEGIN STAR alignment `pwd` `date`
/u/home/eeskin/lnavarro/lib/STAR/STAR_2.3.0e.Linux_x86_64/STAR --genomeDir $ref --readFilesIn $end1  --readFilesCommand zcat --runThreadN 8
echo COMPLETE STAR `pwd` `date`


