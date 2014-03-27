#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#
bam=$1
readLen=$2
outDir=`dirname $1`
#
echo BEGIN run events analysis `pwd` `date`
python /u/home/eeskin/charlesb/.local/bin/run_events_analysis.py --compute-genes-psi=/u/home/eeskin2/charlesb/Victoria_Ho/starAlgn/indexed $bam --output-dir $outDir --read-len=$readLen --use-cluster --chunk-jobs=10 --SGEarray 
echo COMPLETE run events analysis `pwd` `date`
