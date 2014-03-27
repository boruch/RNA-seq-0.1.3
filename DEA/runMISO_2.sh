#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#
inDir=$1
outDir=$2
#
echo BEGIN run miso summary `pwd` `date`
python /u/home/eeskin/charlesb/.local/bin/run_miso.py --summarize-samples $inDir $outDir 
echo COMPLETE run miso summary `pwd` `date`
