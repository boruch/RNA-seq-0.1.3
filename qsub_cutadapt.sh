#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
gz=$1
AdSeq=$2
out=`basename $gz .gz`
cutadapt -a $AdSeq $gz > $out
