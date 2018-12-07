import matplotlib
matplotlib.use('Agg')
from matplotlib import rcParams
rcParams['font.family'] = 'monospace' 
rcParams['font.sans-serif'] = ['Tahoma']
import matplotlib.pyplot as plt
import seaborn as sns
import pandas as pd
import numpy as np
import sys

from sklearn.metrics.pairwise import cosine_similarity
import argparse
import string

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument('--xfile', required=True)
    parser.add_argument('--yfile', required=True)
    parser.add_argument('--title', required=True)
    parser.add_argument('--xname', required=True)
    parser.add_argument('--yname', required=True)
    parser.add_argument('--x_is_log', action='store_true' )
    parser.add_argument('--y_is_log', action='store_true' )
    parser.add_argument('--output_file')
    return parser.parse_args()

def rename_categories(categories):
    strip_punct = lambda s: ''.join(c for c in s if c not in string.punctuation)
    return [strip_punct(cat) for cat in categories]
def rename_df(df):
    old_cols = df.columns.values
    new_cols = rename_categories(old_cols)
    rename_cols = dict(zip(old_cols, new_cols))
    return df.rename(columns=rename_cols)

def main():
    args = parse_args()
    x_df = pd.read_csv(args.xfile, header=0, sep='\t')
    y_df = pd.read_csv(args.yfile, header=0, sep='\t')
    x_df = rename_df(x_df)
    y_df = rename_df(y_df)[x_df.columns.values]

    assert((x_df.columns.values == y_df.columns.values).all())
    x_betas = x_df.values
    y_betas = y_df.values

    if args.x_is_log:
        x_betas = np.exp(x_betas)
    if args.y_is_log:
        y_betas = np.exp(y_betas)

    cos_sims = cosine_similarity(x_betas, y_betas)
    H, W = cos_sims.shape
    plt.subplots(figsize=(W+1, H))
    ax = sns.heatmap(cos_sims, vmin=0, vmax=1, annot=True, linewidths=0.5)
    N, M = cos_sims.shape
    ax.set_yticklabels(np.arange(N)+1, rotation = 0)
    ax.set_ylabel(args.xname)
    ax.set_xticklabels(np.arange(M)+1, rotation = 0)
    ax.set_xlabel(args.yname)
    plot = ax.get_figure()
    plot.savefig(args.output_file)



if __name__ == '__main__':
    main()