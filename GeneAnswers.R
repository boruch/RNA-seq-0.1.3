library(Rgraphviz) # first make sure you are using R/2.12
library(org.Mm.eg.db)
library(GeneAnswers)
library(DESeq)
# input for geneanswers
geneFilesList <- list.files(pattern="SignificantGenes") 
#
for(genes in geneFilesList){
# with pvals and fold change info
de.list <- read.table(genes, header=TRUE, row.name=1)
#de.list <- de.list[!is.na(de.list$id),]
print(head(de.list))
# all input variable
geneInput  <- de.list[1:3]
print(head(geneInput))
# genesInCategory
#conds <- unique(substr(colnames(de.list[4:ncol(de.list)]),1,1))
expr <- de.list[4:ncol(de.list)] 
#c1 <- log2(expr[, c(1,2)]/(rowMeans(expr[, c(3,4)]) + 0.1) + 0.1)
#c2 <- log2(expr[,c(3,4)]/(rowMeans(expr[,c(1,2)]) + 0.1) + 0.1)
geneExpProfile <- cbind(de.list[1], expr)

gxp <- geneExpProfile
lgxp <- gxp
print(head(gxp))
# start geneAnswers output
x <- geneAnswersBuilder(geneInput, annotationLib="org.Mm.eg.db", categoryType='GO', testType="hyperG", known=TRUE, pvalueT = 0.1, FDR.correction=TRUE, geneExpressionProfile=lgxp) # default sort by p-value
xx <- geneAnswersReadable(x)
if(dim(getEnrichmentInfo(x))[1]>5){
#pdf( paste( gsub(".xls","", genes), "_GO_pieChart.pdf", sep=""), height=800, width=800)
#geneAnswersChartPlots(xx, chartType="pieChart", newWindow=FALSE)
#dev.off()
#pdf( paste( gsub(".xls","", genes), "_GO_barplot.pdf", sep=""), height=800, width=800)
#geneAnswersChartPlots(xx, chartType="barPlot",newWindow=FALSE)
#dev.off()
#pdf( paste( gsub(".xls","", genes), "_GO_graph.pdf", sep="")) 
#geneAnswersConceptNet(xx, centroidSize=ifelse(1,'pvalue','foldChange'), output='fixed', showCats=c(3:5), geneLayer=5, symmetry=FALSE)
#dev.off()
#geneAnswersConceptRelation(x, direction='both') # only interactive 
#pdf( paste( gsub(".xls","", genes), "_GO_graph.pdf", sep="")) 
#jj <- geneAnswersConceptNet(xx, centroidSize='foldChange', output='none', showCats=c(3:5), geneLayer=5, symmetry=TRUE)
#plot(jj$graph, main=paste(gsub(".xls","",genes),jj$vertex.attributes$NODES[1], sep="\n"))
#dev.off()
#
pdf(paste( gsub(".xls","", genes), "_GO_heatmap.pdf", sep=""), height=12, width=6)
geneAnswersHeatmap(x, catTerm=TRUE, geneSymbol=TRUE, showCats=c(3:10), showGeneMax=100)
#title(gsub(".xls","",genes))
dev.off()
}
z <- getEnrichmentInfo(x)
gomaps <- as.list(org.Mm.egGO2ALLEGS)
golengths <- rep(0,length(rownames(z)))
for(i in 1:length(rownames(z))){
	golengths[i] <- length(gomaps[rownames(z)[i]][[1]])
	}
out <- cbind( rownames(z), Term(rownames(z)), Ontology(rownames(z)), 23351 - golengths, golengths, dim(de.list)[1] - z[,1], z)
colnames(out)[1:6] <- c("GO:ID", "Term", "Ontology", "Total Genes not in Term", "Total Genes in Term", "genes not in Category")
write.table(out, file=paste("gene_answers_",gsub(".xls", "", genes), "_GO_list.xls", sep="") , quote=FALSE, sep="\t", row.names=FALSE)    
topCategoryGenes(xx, orderby="pvalue", top="ALL", topGenes="ALL", file=TRUE, fileName=paste("gene_answers_", gsub(".xls","", genes),"_GO_Genes.xls", sep=""))
rm("de.list", "geneExpProfile","geneInput", "x", "xx", "z", "out")
}
# later we can add levels of ontology but now leave it out

#cc <- names(which(as.list(GOCCANCESTOR)=="all"))
#level<-0
#CClevels <- rep(0,length(names(as.list(GOCCANCESTOR))))
#names(CClevels) <- names(as.list(GOCCANCESTOR))
#traverse <- function(cc, level){    
#		children <- as.list(GOCCCHILDREN)[cc]
#		if(is.na(cc)){return}
#		if(level>5){return}
#		else{CClevels[cc] <- level}
#                for(child in children[[1]]){
#		    traverse(child, level+1)
#	}}
