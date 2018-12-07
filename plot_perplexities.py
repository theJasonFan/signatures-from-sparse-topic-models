import glob
import matplotlib
matplotlib.use('Agg')
from matplotlib import rcParams
rcParams['font.family'] = 'monospace' 
rcParams['font.sans-serif'] = ['Tahoma']

import seaborn as sns
import pandas as pd
import sys
print('*loading file')
perplexities_file = sys.argv[1]
output_file = sys.argv[2]
output_line_file = sys.argv[3]
df = pd.read_csv(perplexities_file, header=0, sep='\t')

print('*plotting')
ax = sns.boxplot(data=df, x='K', y='perplexity', hue='algorithm')
plot = ax.get_figure()
plot.savefig(output_file)
matplotlib.pyplot.clf()

ax = sns.lineplot(data=df, x='K', y='perplexity', hue='algorithm')
plot = ax.get_figure()
plot.savefig(output_line_file)
print('*plotted')

