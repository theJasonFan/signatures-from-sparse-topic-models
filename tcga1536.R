library('Matrix')
library(stm)
library(tm)
library(ggplot2)


Ks <- c(3,6,12, 18)
max.its <- 75
cv.iters = 5


data <- read.csv("data/counts.TCGA.WES.SBS-1536.tsv", sep='\t', row.names=1, header=T)
all_docs <- readCorpus(data, type="dtm")
vocab <- colnames(data)


if(!dir.exists('output')){
  dir.create('output')
}

if (!dir.exists('output/tcga1536')){
    dir.create('output/tcga1536')
}

verbose <- T
df <- data.frame('perplexity' = -1.0, 'K'=-1, 'algorithm'= 'NULL', stringsAsFactors = F)
for (i in 0:(cv.iters-1)){
  for (K in Ks){
    SAGE.betas.fp = sprintf('output/tcga1536/sage-K%d-iter%d-betas.tsv', K, i)
    LDA.betas.fp = sprintf('output/tcga1536/ctm-K%d-iter%d-betas.tsv', K, i)
    
    train_test_docs <- make.heldout(all_docs$documents, all_docs$vocab, proportion=0.2)
    sage.model <- stm(train_test_docs$documents, train_test_docs$vocab, K, max.em.its = max.its,
                      LDAbeta = F, interactions=F, 
                      verbose = verbose, reportevery = max.its,
                      sigma.prior = 1)
    lda.model <- stm(train_test_docs$documents, train_test_docs$vocab, K, max.em.its = max.its,
                     verbose = verbose, reportevery = max.its,
                     LDAbeta=T, interactions=F,
                     sigma.prior = 1)
    
    sage.likelihood <- eval.heldout(sage.model, train_test_docs$missing)
    cat('SAGE perplexity:', -sage.likelihood$expected.heldout, '\n')
    df = rbind(df, list(-sage.likelihood$expected.heldout, K, 'SAGE-CTM'))
    
    lda.likelihood <- eval.heldout(lda.model, train_test_docs$missing)
    cat('LDA perplexity:', -lda.likelihood$expected.heldout, '\n')
    df = rbind(df, list(-lda.likelihood$expected.heldout, K, 'CTM'))
    
    # GET LOG_BETAS (log prob of generating word)
    sage.beta = sage.model$beta$logbeta[[1]]
    lda.beta = lda.model$beta$logbeta[[1]]
    
    write.table(sage.beta, file=SAGE.betas.fp, quote=F, sep='\t',
                col.names = sage.model$vocab, row.names=F)
    write.table(lda.beta, file=LDA.betas.fp, quote=F, sep='\t',
                col.names = sage.model$vocab, row.names=F)
  }
}

df <- df[2:nrow(df), ]
stopifnot(nrow(df) == (length(Ks) * cv.iters * 2))
write.table(df, file='output/tcga1536/perplexities.tsv', quote=F, sep='\t',
            col.names = T, row.names=F)

