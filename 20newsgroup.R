library('Matrix')
library(stm)
library(tm)
library(RTextTools)

## load dplyr and tidyr for data munging
library(dplyr)
library(tidyr)



Ks <- c(50)
max.its <- 75
cv.iters = 1


data <- read.csv("http://ssc.wisc.edu/~ahanna/20_newsgroups.csv", stringsAsFactors = F)
data <- data[-1]
dtm <- create_matrix(data, language="english")

all_docs <- readCorpus(dtm, type='dtm')
vocab <- colnames(all_docs$vocab)


if(!dir.exists('output')){
  dir.create('output')
}

if (!dir.exists('output/20news')){
  dir.create('output/20news')
}

verbose <- T
df <- data.frame('perplexity' = -1.0, 'K'=-1, 'algorithm'= 'NULL', stringsAsFactors = F)
for (i in 0:(cv.iters-1)){
  for (K in Ks){
    SAGE.betas.fp = sprintf('output/20news/sage-K%d-iter%d-betas.tsv', K, i)
    LDA.betas.fp = sprintf('output/20news/ctm-K%d-iter%d-betas.tsv', K, i)
    
    train_test_docs <- make.heldout(all_docs$documents, all_docs$vocab, proportion=0.2)
    sage.model <- stm(train_test_docs$documents, train_test_docs$vocab, K, max.em.its = max.its,
                      LDAbeta = F, interactions=F, 
                      verbose = verbose, reportevery = max.its,
                      sigma.prior = 1)
    lda.model <- stm(train_test_docs$documents, train_test_docs$vocab, K, max.em.its = max.its,
                     verbose = verbose, reportevery = max.its,
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
write.table(df, file='output/20news/perplexities.tsv', quote=F, sep='\t',
            col.names = T, row.names=F)

