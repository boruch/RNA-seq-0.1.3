#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -pe shared 2
#$ -l mem=4G,time=8:00:00
#$ -V
#$ -r n
indexes=/u/home/eeskin/charlesb/RNAseqTools/bin/indexes/hg19
end1=$1
end2=$2
refGtf=$3
outDir=`basename $end1 _1.fastq`
#isILMN=`illuminaPhredScoreRange.sh $fq | awk '{print $2}'`
tophat -G $refGtf -g 10 -T -o $outDir --phred64-quals -p 2 -r -15 $indexes $end1 $end2
