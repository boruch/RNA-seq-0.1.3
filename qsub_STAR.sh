#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 8
#$ -l h_data=4G,time=4:00:00,exclusive
#$ -V		

# include full path to input
end1=$1
end2=$2
ref=$3

echo BEGIN STAR alignment `pwd` `date`
#/u/home/eeskin/lnavarro/lib/STAR/STAR_2.3.0e.Linux_x86_64/STAR --genomeDir $ref --readFilesIn $end1 $end2 --outReadsUnmapped Fastx --runThreadN 8
/u/home/eeskin/lnavarro/lib/STAR/STAR_2.3.0e.Linux_x86_64/STAR --genomeDir $ref --readFilesIn $end1 $end2 --runThreadN 8
echo COMPLETE STAR `pwd` `date`


