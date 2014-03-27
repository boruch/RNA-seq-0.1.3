#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 6
#$ -l mem=4G,time=4:00:00,highp
#$ -V
#
### include full path to input fastqs
bams1=$1
bams2=$2 # replicates must be comma separated
gtf=$3 ### FUll pathi
labels=$4 # comma separated
#
echo BEGIN cuffdiff `pwd` `date`
#
### run it with bam files
#
cuffdiff -o cuffdiff_out --FDR 0.1 -p 6 --library-type ff-firststrand -L $labels $gtf $bams1 $bams2
#
echo COMPLETE cuffdiff `pwd` `date`
