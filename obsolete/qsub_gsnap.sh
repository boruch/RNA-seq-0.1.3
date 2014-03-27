#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 4
#$ -l mem=4G,time=23:00:00
#$ -V
#$ -r n
end1=$1
end2=$2
outDir=$3
#sampleDir=`dirname $end1`
#sample=`basename $sampleDir`
#gsnap -D /u/home/eeskin/charlesb/share -d hg19 -N 1 --pairexpect=170 -J 64 --fails-as-input --split-output=$sample $end1 $end2
echo BEGIN gsnap alignment `pwd` `date`
~/bin/gsnap -D /u/home/eeskin/charlesb/share -d hg19 -t 4 -B 4 -n 5 -Q -A sam -N 1 --pairexpect=185 -J 64 $end1 $end2 > $outDir/gsnap.sam
echo COMPLETE gsnap `date`
