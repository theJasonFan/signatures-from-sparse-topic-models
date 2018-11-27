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

def parse_args():
    parser = ArgumentParser()
    parser.add_argument('--input', required=True)
    parser.add_argument('--output_file', required=False, default='out.png')
    parser.add_argument('--cores', type=int, default=10)
    parser.add_argument('--n_folds', type=int, default=10)
    parser.add_argument('--rank_range', type=int, nargs='*', default=[3, 6, 9, 12, 15, 18])
    return parser.parse_args()

def counts_to_bow(arr):
    N, M = arr.shape
    bow = [list(zip(range(M), counts)) for counts in arr]
    return bow
    
def main():
    args = parse_args()
    print('* Loading data from ', args.input)
    data_df = pd.read_csv(args.input, header=0, index_col=0, sep='\t')
    samples_bow = counts_to_bow(data_df.values)

    samples_train, samples_test = train_test_split(samples_bow, test_size=0.1)

    print('* Training LDA models')
    print('\t - # folds', args.n_folds)
    print('\t - # Ranks', args.rank_range)

    print('* Perplexities: ')
    kf = KFold(n_splits=args.n_folds)
    perps = []
    Ks = []
    models = defaultdict(list)
    for train_index, test_index in kf.split(samples_bow):
        samples_train = [samples_bow[i] for i in train_index]
        samples_test = [samples_bow[i] for i in test_index]
        for K in args.rank_range:
            lda = LdaMulticore(
                    samples_train,
                    num_topics=K,
                    workers=args.cores)
            perp = lda.log_perplexity(samples_test)
            print('\t {}: {}'.format(K, perp))
            Ks.append(K)
            perps.append(perp)
            models[K].append(lda)

    print(perps, Ks)

    perp_df = pd.DataFrame({'log_perplexity': perps, 'num_topics': Ks})
    ax = sns.boxplot(x='num_topics', y='log_perplexity', data=perp_df)
    plot = ax.get_figure()
    plot.savefig(args.output_file)

if __name__ == "__main__":
    main()
