#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V
#$ -l time=72:00:00,h_data=2G,highp
source /u/local/Modules/default/init/modules.sh
ref=$1
out=$2
echo Begin: `date` 1>&2
echo -e gene'\t'$out > $out.count.txt
samtools view -Sh Aligned.out.sam | htseq-count -m intersection-nonempty -s 'no' - $ref 2> $out.count.error.log >> $out.count.txt
echo count table for $sample complete `date` 1>&2
