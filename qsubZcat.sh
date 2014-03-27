#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=4:00:00,mem=2G,highp
gz=$1
echo BEGIN unzipping $gz `date`
zcat $gz > `basename $gz .gz`
echo DONE $gz unzippped `date`
