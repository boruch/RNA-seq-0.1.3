#!/bin/bash
#$ -S /bin/bash
#$ -cwd
#$ -V

# The reference should be located in the lib/STAR directory i.e. ~/lib/STAR_2.1.4a/Mouse_mm9
ref=$1
# There needs to be a "Data:" folder that include the input fastqs
# The Data folder should include the input fastq and 
for i in $PWD/Data/*.fastq.gz; do nDir=`basename $i .fastq.gz`; mkdir $nDir; pushd $nDir; ln -s $i .; qsub /u/home/eeskin/charlesb/PIPELINE/RNA-seq-0.1.3/qsub_STAR_SE.sh *.fastq.gz $ref; popd; done
