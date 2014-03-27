#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 6
#$ -l mem=4G,time=23:30:00,highp
#$ -V
#
### include full path to input fastqs
bams1=$1
bams2=$2 # replicates must be comma separated
gtf=$3 ### FUll path
#
echo BEGIN MATS `pwd` `date`
#
### run it with bam files
#
python /u/home/eeskin/charlesb/lib/MATS.3.0.6.beta/RNASeq-MATS.py -b1 $bams1 -b2 $bams2 -gtf $gtf -o MATS_BAMS -t paired -len 100 -a 8 -c 0.05 -analysis U -expressionChange 10
#
echo COMPLETE MATS `pwd` `date`
