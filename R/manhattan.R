times<-Sys.time() 
library('qqman',lib.loc="/home/Group/dna/soft/GWAS/R-package")
library('getopt')
options(bitmapType='cairo')
spec = matrix(c(
    'infile','f',0,'character',
    'outfile','o',0,'character'
     ), byrow=TRUE, ncol=4);
opt = getopt(spec);
print_usage <- function(spec=NULL){
    cat(getopt(spec, usage=TRUE));
    cat("Usage example: \n")
    cat("
    Usage example: 

    Usage:
    --infile 
    --outfile
    --help      usage
    \n")
    q(status=1);
}
if ( !is.null(opt$help) ) { print_usage(spec) }
if ( is.null(opt$infile) ) { print_usage(spec) }
if ( is.null(opt$outfile) ) { print_usage(spec) }

mydata<-read.table(opt$infile,header = TRUE,sep="")
newdata<-na.omit(mydata)
png(paste(opt$outfile,".png",sep=""),height=900,width=1800)
#,"X","Y"
manhattan(newdata,suggestiveline=-log10(1e-3),cex.lab=1.1,chrlabs = c(1:22),col = c("blue4", "orange3"),cex.axis = 1.5,cex = 1.2,main = "Manhattan Plot")
dev.off()
pdf(paste(opt$outfile,".pdf",sep=""),height=10,width=18)
#"X","Y"
manhattan(newdata,suggestiveline=-log10(1e-3),cex.lab=1.1,chrlabs = c(1:22),col = c("blue4", "orange3"),cex.axis = 1.5,cex = 1.2,main="Manhattan Plot")
dev.off()
png(paste(opt$outfile,".QQ.png",sep=""),height=900,width=1600)
qq(mydata$P)
dev.off()
pdf(paste(opt$outfile,".QQ.pdf",sep=""))
qq(mydata$P)
dev.off()

escaptime=Sys.time()-times;
print("Done!")
print(escaptime) 
