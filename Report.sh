#!/bin/bash
#$ -V
#$ -cwd
#
#
find . -name *.count.txt -exec ~/project/PIPELINE/bin/cjoin.awk {} + > Report/metaReadCount.xls
find . -name sorted_chrHits.txt -exec ~/project/PIPELINE/bin/cjoin.awk {} + > Report/chrHits.xls
head -1 Report/metaReadCount.xls > Report/hitCount.xls
head -1 Report/metaReadCount.xls > Report/mismatch.xls
find . -name sorted_mismatch.txt -exec ~/project/PIPELINE/bin/cjoin.awk {} + >> Report/mismatch.xls
find . -name sorted_hits.txt -exec ~/project/PIPELINE/bin/cjoin.awk {} + >> Report/hitCount.xls 
find . -name refFlat.coverageSum -exec ~/project/PIPELINE/bin/cjoin.awk {} + > Report/coverage.xls
find . -name ensembl.coverageSum -exec ~/project/PIPELINE/bin/cjoin.awk {} + > Report/coverage2.xls
