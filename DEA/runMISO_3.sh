#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#
xDir=$1
yDir=$2
outDir=$PWD
#
echo BEGIN run miso compare `pwd` `date`
python /u/home/eeskin/charlesb/.local/bin/run_miso.py --use-cluster --chunk-jobs=10 --compare-samples $xDir $yDir $outDir 
python /u/home/eeskin/charlesb/.local/bin/filter_events.py filter_events.py --filter $xDir_vs_$yDir/bayes-factors/control_vs_treatment.miso_bf --num-inc 1 --num-exc 1 --num-sum-inc-exc 10 --delta-psi 0.20 --bayes-factor 10 --output-dir filtered/
echo COMPLETE run miso compare `pwd` `date`
