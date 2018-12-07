import glob
import matplotlib
matplotlib.use('Agg')
from matplotlib import rcParams
rcParams['font.family'] = 'monospace' 
rcParams['font.sans-serif'] = ['Tahoma']

import seaborn as sns
import pandas as pd
import numpy as np
import sys
import string

def rename_categories(categories):
    strip_punct = lambda s: ''.join(c for c in s if c not in string.punctuation)
    return [strip_punct(cat) for cat in categories]

def main():
    sage_betas_file = sys.argv[1] # 'output/sage-K12-iter0-betas.tsv'
    lda_betas_file = sys.argv[2] #'output/lda-K12-iter0-betas.tsv'
    term_freqs_file = sys.argv[3] #'data/counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv'
    output_file = sys.argv[4] 

    df = pd.read_csv(term_freqs_file, header=0, sep='\t', index_col=0)

    old_cols = df.columns.values
    new_cols = rename_categories(old_cols)
    rename_cols = dict(zip(old_cols, new_cols))
    df = df.rename(columns=rename_cols)

    lda_betas_df = pd.read_csv(lda_betas_file, header=0, sep='\t')
    sage_betas_df = pd.read_csv(sage_betas_file, header=0, sep='\t')

    # The R code removes '[', '>'. ']' symbols, and replaces with '.'
    # A hacky way to make col names the same is to remove punctuation
    lda_cols = rename_categories(lda_betas_df.columns.values)
    sage_cols = rename_categories(sage_betas_df.columns.values)

    assert(sage_cols == lda_cols)
    df = df[sage_cols]

    col_sums = df.sum().values
    cols = df.columns.values
    idxs = np.argsort(col_sums)
    cols_sorted = cols[idxs] 
    print(col_sums[idxs[:10]])
    print(cols_sorted[:10])
    print(col_sums[idxs[-10:]])
    print(cols_sorted[-10:])

    sage_betas = sage_betas_df.values
    lda_betas = lda_betas_df.values

    sage_variation = variation(sage_betas)
    lda_variation = variation(lda_betas)
    sage_variation_sorted = sage_variation[idxs]
    lda_variation_sorted = lda_variation[idxs]

    sage_variation_sorted = np.cumsum(sage_variation_sorted)
    lda_variation_sorted = np.cumsum(lda_variation_sorted)

    #sage_variation_sorted = deciles(sage_variation_sorted)
    #lda_variation_sorted = deciles(lda_variation_sorted)
    N = len(lda_variation_sorted)

    X = np.hstack((np.arange(N), np.arange(N)))
    Y = np.hstack((sage_variation_sorted, lda_variation_sorted))
    algorithm = (['SAGE-CTM'] * N) + (['CTM'] * N)

    data = dict(term_freq_rank=X, total_variation=Y, algorithm=algorithm)
    data_df = pd.DataFrame(data=data)
    
    ax = sns.lineplot(data=data_df, x='term_freq_rank', y='total_variation', hue='algorithm')

    plot = ax.get_figure()
    plot.savefig(output_file)
def variation(betas, exp=True):
    if exp:
        betas = np.exp(betas)
    
    mean_betas = np.sum(betas, axis=0, keepdims=True)
    diff_betas = np.abs(betas - mean_betas)
    betas_var = np.sum(diff_betas, axis=0)
    total_var = np.sum(betas_var)
    proportion_of_var = betas_var / total_var
    return proportion_of_var

def deciles(sorted_vars):
    df = pd.DataFrame({'A': sorted_vars})
    return df.groupby(pd.qcut(df.A, 200))['A'].sum().values


if __name__ == '__main__':
    main()