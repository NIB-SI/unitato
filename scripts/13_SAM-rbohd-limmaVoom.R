#' ---
#' title: "limmaVoom DE analysis of PVY-infected Rywal"
#' author: "National Institute of Biology"
#' date: "March 22nd, 2024"
#' ---

library ("limma")
library("edgeR")
library("stringr")

#' # Prepare data
#' ## Import counts and determine groups
#' 
x <- read.table("./counts.txt", header=TRUE, sep="\t", row.names="GeneID", stringsAsFactors=FALSE, dec = ".")
colnames(x)
group <- factor(c(1,1,1,2,2,2))

#' ## Create a DGEList object

y <- DGEList(counts=x, group=group)

#' ## Plot read density

col <- c(rep("green", 3), rep("red", 3))
nsamples <- ncol(x)
lcpm <- log(as.matrix(x),10)

plot(density(lcpm), col=col[1], lwd=2, ylim=c(0,0.3), las=2, main="", xlab="")
title(main="A. BEFORE REMOVAL", xlab="Log-cpm")
abline(v=0, lty=3)

for (i in 2:nsamples){
  den <- density(lcpm[,i])
  lines(den$x, den$y, col=col[i], lwd=2)
}

#' # Filtering and normalisation
#' ## Filter genes based on expression 
keep <- filterByExpr(y, group=group, min.count=50, min.total.count=100)
y1 <- y[keep, ,keep.lib.sizes=FALSE]

dim(y$counts)
dim(y1$counts)

#' ## TMM normalisation

y1 <- calcNormFactors(y1, method="TMM")


#' ## Filtering and normalisation QC  

#' ### Boxplot of raw counts
boxplot(log(y$counts+1,10), las=2, ylab="log10(counts)", col=col)

#' ### Boxplot of filtered counts
boxplot(log(y1$counts+1,10), las=2, ylab="log10(counts)", col=col)

#' ### Boxplot of filtered and normalised counts
lcpm <- cpm(y1, log=TRUE)
boxplot(lcpm, ylab="cpm_TMM_normalization", col=col, las=2)

#' ### Density plots before and after removing low expressed genes

opar <- par(mfrow=c(1,2), cex = 0.6)
nsamples <- ncol(x)

lcpm <- log(as.matrix(x),10)
plot(density(lcpm), col=col[1], lwd=2, ylim=c(0,0.6), las=2, main="", xlab="")
title(main="A. BEFORE REMOVAL", xlab="Log-cpm")
abline(v=0, lty=3)
for (i in 2:nsamples){
  den <- density(lcpm[,i])
  lines(den$x, den$y, col=col[i], lwd=2)
}

lcpm <- log(as.matrix(y1),10)
plot(density(lcpm), col=col[1], lwd=2, ylim=c(0,1), las=2, main="", xlab="")
title(main="B. AFTER REMOVAL", xlab="Log-cpm")
abline(v=0, lty=3)
for (i in 2:nsamples){
  den <- density(lcpm[,i])
  lines(den$x, den$y, col=col[i], lwd=2)
}

par(opar)

#' ### MDS (PCA-like) graph

plotMDS(y1, labels=colnames(y1), col = col, cex = 2)

lcpm <- log(as.matrix(y1),10)
plotMDS(lcpm, labels=colnames(lcpm), col = col, cex = 2)

#' # limma-voom protocol
#'## Create design matrix
design <- model.matrix(~0+group)
colnames(design) <- c("pvy", "mock")


#' ## limma-voom fit for filtered RNA-seq dataset
fit <- edgeR::voomLmFit(y1,design, plot= TRUE)

#' ## Define contrasts

contrastMatrix = makeContrasts("pvy-mock",levels=design)
fit2 = contrasts.fit(fit, contrastMatrix)


#' ## eBayes statistics calculation

fit2 <- eBayes(fit2)
plotSA(fit2)


#' ## Prepare results table

Rywal <- topTable(fit2, coef=1, number=1000000, sort.by="none")
results <- cbind(Rywal[,1], Rywal[,5])
colnames(results) <- c(paste(colnames(fit2$contrasts),"_logFC", sep=""),paste(colnames(fit2$contrasts),"_padj", sep=""))
rownames(results) <- rownames(Rywal)
results.raw <- merge(results, y1$counts*y1$samples$norm.factors, by.x="row.names", by.y="row.names", all.x= TRUE, all.y= FALSE, sort= FALSE)
head(results.raw)


#' # Session information

sessionInfo()








