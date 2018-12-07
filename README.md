# CMSC828P Final Project - Motivating sparse topic models for mutational signatures

## Goal
The goal of this project is to motivate possible future work for learning sparse, pan-cancer signatures using topic models. Specifically, this project's aim is to start building a knowledge base with regard to generative models for mutational signatures. We will apply Multinomial and Sparse Additive GEnerative models (SAGE) based to SNP mutation counts to work towards answering the following questions:

-   Can we motivate using SAGE-like models over Multinomial models?    
-   Do Multinomial models ‘overfit’ to rare mutation categories in the like the way they do for natural language?
-   What are the differences in terms of signatures learned for SAGE-like vs Multinomial models?

## Data:
To limit the scope of the investigation, we will apply topic models to breast cancer cohorts using the following three datasets:

 -  Mutation counts for 96 tri-nucleotide categories of 560 breast cancer whole genomes from Nik-Zainal et. al 2016
 - Mutation counts for 96 tri-nucleotide categories for 1020 breast cancer whole exomes from TCGA
 - Mutation counts for 1536 two-flanking base categories for 1020 breast cancer whole exomes from TCGA
 
 We compare WES and WGS datasets because WES will have mutational categories with more rare terms. Furthermore, we compare signatures and models for 96 vs 1536 mutational categories for the same reason. We would like to see if the claims made by Eisenstein et. al in [1] apply to mutational signatures; specifically, we would like to see if SAGE based models learn signatures that result in lower perplexity and are more robust by attributing less total variation to rare terms.

## Topic Models
From the Structural Topic Models R Package, we use correlated topic models that model mutation probabilities with:

 1. Multinomial distributions directly (akin to other multinomial models like LDA)
 2. Log deviations from an uninformative mean distributions. This is a SAGE model.

## Experimental procedure
We applied the multinomial CTM model and the SAGE based CTM model to the three datasets and analyzed the following:

0. Evaluated learned models for perplexity; reproduce figure 3 from [1]
1. Evaluated learned topics for sparsity and total variation attributed to frequent and rare terms; reproduce figure 4 from [1]
2. Compared learned signatures to COSMIC signatures

(Note: For the SAGE based CTM model, we used the mean counts of each mutation category over the cohorts as the background term frequency count)

## Results

Using 96 categories of SBS mutations (one 3' and 5' flanking base) we find almost no difference in perplexity or learned signatures. The figures 1, 2, 3, and 4, below that the both the SAGE and Multinomial CTM models learn the achieve the lowest perplexity with the same model ranks (6 and 12, respectively).

![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/nz2016/perplexities_boxplot.png?raw=true)
Figure 1. Perplexity of SAGE based, (SAGE-CTM) and Multinomial based (CTM) model trained on 560 whole genomes with 96 mutational categories.

![enter image description here](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/tcga96/perplexities_boxplot.png?raw=true)
Figure 2. Perplexity of SAGE based, (SAGE-CTM) and Multinomial based (CTM) model trained on 1020 whole exomes with 96 mutational categories.

![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/nz2016/sage-vs-ctm-sigs.png?raw=true)
Figure 3. Cosine similarity of learned signatures over 96 mutational categories for 560 whole genomes for SAGE-CTM and CTM models.

![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/tcga96/sage-vs-ctm-sigs.png?raw=true)
Figure 4. Cosine similarity of learned signatures over 96 mutational categories for 560 whole genomes for SAGE-CTM and CTM models.


For the 1020 WES breast cancers with 1536 mutational categories, as shown by figure 5 the two models again fit best to the data with the same model rank at K=6. However, at a higher choice of K=18, the SAGE-CTM model outperforms the CTM model by a large margin. In terms of learned signatures, we see that SAGE-CTM and CTM learn one different signature with 1536 mutational categories; this is shown in figure 6.
![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/tcga1536/perplexities_boxplot.png?raw=true)
Figure 5. Perplexities of SAGE-CTM and CTM model trained on 1020 WES breast cancer data with 1536 mutational categories. 
![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/tcga1536/sage-vs-ctm-sigs.png?raw=true)
Figure 6. Cosine similarities of signatures learned by SAGE-CTM and CTM model trained on 1020 WES breast cancer data with 1536 mutational categories. 

In terms of total variation attributed terms with the lowest frequencies, we can see from figures 7, 8 and 9 that regardless of dataset and mutational categories, SAGE-CTM and CTM models attribute similar proportions of total variation to the rarest N terms.
![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/nz2016/total_variation.png?raw=true)
Figure 7. Total variation of the rarest N terms for the SAGE-CTM model fitted to 560 WGS breast cancers (96 categories)

![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/tcga96/total_variation.png?raw=true)
Figure 8 Total variation of the rarest N terms for the SAGE-CTM model fitted to 1020 WES breast cancers (96 categories)
![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/tcga1536/total_variation.png?raw=true)
Figure 9. Total variation of the rarest N terms for the SAGE-CTM model fitted to 1020 WES breast cancers (1536 categories)

In terms of signatures learned by the SAGE-CTM model, for the 560 whole breast cancer genomes, we were able to recover 5 of the 12 signatures found by Nik Zainal et. al in [2] with cosine similarity of greater than 0.9. 
![](https://github.com/theJasonFan/signatures-from-sparse-topic-models/blob/master/output/nz2016/SAGE-CTM-vs-COSMIC-sigs.png?raw=true)
Figure 10. Signatures 1, 2, 3, 13, and 17 were found in 560 whole breast cancer genomes.

Interestingly, for the 1020 whole breast cancer exomes, we find 12 signatures, 4 of which have cosine similarity greater than or equal to 0.85 with a COSMIC signature. Signature 1, which is found in all cancers is found with high smilarity. Many signatures similar to COSMIC signatures, like signature 10 that is found by the SAGE-CTM are signatures found commonly in bladder and urethelial cancers.

## Takeaways and conclusions
Unfortunately, we were unable to tease out the differences of modelling mutational signatures as mixtures multinomial distributions directly versus mixtures of log deviations of mutational term frequencies. From Figure 5, we hypothesize that more data with more active mutational categories would be necessary to see the difference in perplexities of learned models. It is still unclear as to the differences in the robustness of learned signatures in terms of total variation attributed to rare terms. We hypothesize that applying the SAGE-CTM and CTM model to a pan cancer cohort in which rare terms may be restricted to certain cancer types may reveal the differences between dirichlet-multinomial and sparse additive models as reported in [1].

## References
  
1.  Eisenstein, Ahmed & Xing (2011) "Sparse additive generative models of text."  _ICML_
2. Alexandrov, L. B., Nik-Zainal, S., Wedge, D. C., Campbell, P. J. & Stratton, M. R. (2013) "Deciphering signatures of mutational processes operative in human cancer." _Cell Rep._  **3**, pages 246–259. [doi:10.1016/j.celrep.2012.12.008](https://doi.org/10.1016/j.celrep.2012.12.008)