#setwd("Desktop/test/test_gobar/")
gos <- list.files(pattern="*Gene_Ontology_Report.xls")
for(go in gos){
	pdf(paste("Gene_Ontology_",strsplit(go,"_")[[1]][3],"_gobar.pdf",sep=""),height=12,width=8)
	par(mfrow=c(3,1)) 
	f <- read.table(go, header=TRUE, sep="\t",row.name=1, fill=TRUE)
	rowlim <- 25
	GOcl <- c("BP","MF","CC")
	for(ll in 1:length(GOcl)){
		if(length(which(f[2]==GOcl[ll]))>0){
		toplot <- f[which(f[2]==GOcl[ll]),c(1,11)]
		toplot<-toplot[order(toplot[,2]),]	
		toplot[,2]<- -log10(toplot[,2]) #converts p values in -log10 (pvalue)
	    if (nrow(toplot) > rowlim) {
			toplot<-toplot[1:rowlim,]
			}
		toplot<-toplot[order(toplot[,2]),]
		newTerm <- paste(f[rownames(toplot),1]," (", f[rownames(toplot),6], ")", sep="")
		#checking the fold changes
		toplotFC <- f[rownames(toplot), c(13,15)]/f[rownames(toplot),6]*toplot[,2]
		rownames(toplotFC) <- NULL
		barplot(t(toplotFC),horiz=T,col=c("brown1","darkolivegreen1"), xlab="-Log (p-value)",ylab="",cex.lab=1.3,
               main=paste(strsplit(go,"_")[[1]][3], "\n", GOcl[ll],sep=" "),cex.axis=2) -> BPvalues
               text(newTerm,y=BPvalues,x=0.1,adj=c(0,0),pos=4,cex=.8)
     		   box()
		}}
	dev.off()	 
	}
