import pickle
from argparse import ArgumentParser
from collections import defaultdict

import matplotlib
matplotlib.use('Agg')
from matplotlib import rcParams
rcParams['font.family'] = 'monospace' 
rcParams['font.sans-serif'] = ['Tahoma']

import numpy as np
import pandas as pd
import seaborn as sns
from gensim.models import LdaMulticore
from sklearn.model_selection import KFold, train_test_split

def counts_to_bow(arr):
    N, M = arr.shape
    bow = [list(zip(range(M), counts)) for counts in arr]
    return bow
    
def main():
    print('* Loading data from ', 'data/counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv')
    data_df = pd.read_csv('data/counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv', header=0, index_col=0, sep='\t')
    samples_bow = counts_to_bow(data_df.values)
    samples_train, samples_test = train_test_split(samples_bow, test_size=0.2)
    lda = LdaMulticore(
                    samples_train,
                    num_topics=12)
    topics = lda.get_topics()
    print(topics.shape)
    df = pd.DataFrame(data=topics, columns=data_df.columns.values)
    df.to_csv('output/gensim_betas.tsv', header=True, index=False, sep='\t')

main()