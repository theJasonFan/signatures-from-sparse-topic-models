# CMSC828P Final Project - Motivating sparse topic models for mutational signatures

## Goal
The goal of this project is to motivate possible future work for learning sparse, pan-cancer signatures using topic models. Specifically, this project's aim is to start building a knowledge base with regard to generative models for mutational signatures. We will apply LDA and Sparse Additive GEnerative models (SAGE) to SNP mutation counts to work towards answering the following questions:

0. Will topic models like LDA learn signatures that are 'good' and similar to those found and validated in COSMIC? Are the perplexities low? and are the signatures sparse?
1. Is SAGE's claim of 'sparser' topics true for mutational signatures (in comparison to LDA)?
2. Does is SAGE-like model which models term-frequency deviations from a *background* yield sparser or better signatures? What is the best way to model the background? By opportunity or by the mean across samples?
3. Is a SAGE-like model a suitable candidate for semi-supervised learning of signatures?

## Priority Queue of experiments
0. Apply LDA to the same data as Nik-Zainal, et al. 2016 "Landscape of somatic mutations in 560 breast cancer whole-genome sequences".
	a. Evaluate learned models for perplexity; reproduce figure 3 from [1]
	b. Evaluate learned topics for sparsity; reproduce figure 4 from [1]
1. Apply SAGE and repeat 0a and 0b for SAGE

## Overview of validation plan
1. Compare learned signature to COSMIC signatures. 
2. Compare LDA and SAGE using figures w.r.t perplexity and sparsity in order to motivate future work.

## References
  
1.  Eisenstein, Ahmed & Xing (2011) "Sparse additive generative models of text."  _ICML_
