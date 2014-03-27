#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 3
#$ -l mem=4G,time=6:00:00,highp
#$ -V
#
### include full path to input fastqs
SAM=$1
REF=$2 ### fai file
#
echo BEGIN sam to bam with python `pwd` `date`
#
### run it with bam files
#
python /u/home/eeskin/charlesb/.local/bin/sam_to_bam.py --convert=$SAM `dirname $SAM` --ref=$REF
#
echo COMPLETE sam to bam with python `pwd` `date`
