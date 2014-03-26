#$ -cwd
#$ -V


# $1 is the "SignificantGenes*.xls" file otput from DESeq
# do this before running this script mkdir GO_plots; mv *.pdf GO_plots/
# this works for updated version of GeneAnswers.R
de_list=$1
go_genes=gene_answers_`basename $de_list .xls`_GO_Genes.xls
go_list=gene_answers_`basename $de_list .xls`_GO_list.xls
out_GO=GA_`basename $de_list .xls`_Gene_Ontology_Report.xls
out_DE=GO_$de_list
cat $go_genes | cut -f1,3 |sed 's/ /-/g' |awk 'NR>3{print $1 "\t" $2}' | sed 's/\"//g' | sort -k2,2 > GO_GenesList # this is the output from GeneAnswers.R that contains the GOID and entrezID "*_GO_Genes.xls"
# get list of up and down regulated genes

#cat $de_list | cut -f1,6 | awk '$1 !~ "id"{ if($2 !~ /-/) print $1 "\t1\t0"; else print $1 "\t0\t1"}' | sort -k1,1 > gene_regulations
#join -1 2 -2 1 GO_GenesList gene_regulations | sed 's/ /\t/g' | sort -k2,2 | awk '{up[$2]+=$3;down[$2]+=$4;list[$2]=$2; genes[$2]=genes[$2]"," $1}END{for(i in list) print list[i]"\t"up[i]"\t"down[i]"\t"genes[i]}' > GO_merged

cat $de_list | cut -f1,3 | awk 'NR>1{ if($2 !~ /-/) print $1 "\t1"; else print $1 "\t0"}' | sort -k1,1 > gene_regulations
join -1 2 -2 1 GO_GenesList gene_regulations | sed 's/ /\t/g' | sort -k2,2 | awk '{if($3 ~ /1/) {up[$2]++;upGn[$2]=upGn[$2]","$1} else {down[$2]++;downGn[$2]=downGn[$2]","$1} list[$2]=$2}END{for(i in list) print list[i]"\tTOTAL_UPREGULATED:"up[i]"\tUPREGULATED_GENES:"upGn[i]"\tTOTAL_DOWNREGULATED:"down[i]"\tDOWNREGULATED_GENES:"downGn[i]}' > GO_merged

join -1 2 -2 1 <(cat $go_list | sed 's/ /-/g'| sort -k2,2) <(sort -k1,1 GO_merged) | sed 's/ /\t/g' | awk '{temp=$1; $1=$2; $2=temp}{print}' | sed 's/ /\t/g' > GO_total
cat <(head -1 $go_list | awk '{print $0 "\tnumber upregulated\tupregulated genes\tnumber downregulated\tdownregulated genes"}') <(sort -k7 -nr GO_total) | sed 's/GENES:,/GENES:/g' > out_GO_1 
cat out_GO_1 | sed 's/TOTAL_UPREGULATED:\t/0\t/g' | sed 's/TOTAL_DOWNREGULATED:\t/0\t/g' | sed 's/TOTAL_UPREGULATED://g' | sed 's/TOTAL_DOWNREGULATED://g' > $out_GO
cat GO_GenesList | awk '{go[$2]=go[$2]","$1}END{for(i in go) print i "\t" go[i]}' > geneWgo
join -a 1 -1 1 -2 1 <(sort -k1,1 $de_list) <(sort -k1,1 geneWgo) | sed 's/ /\t/g' | sed 's/\t,/\t/g' > delistWgo
cat <(head -1 $de_list | awk '{print $0 "\tSignificant Gene Ontologies"}') delistWgo > $out_DE
rm GO_GenesList gene_regulations GO_merged GO_total geneWgo delistWgo out_GO_1
