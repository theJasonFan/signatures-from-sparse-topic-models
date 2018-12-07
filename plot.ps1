python plot_perplexities.py 'output\nz2016\perplexities.tsv' 'output\nz2016\perplexities_boxplot.png' 'output\nz2016\perplexities_lineplot.png'
python plot_betas.py 'output\nz2016\sage-K6-iter0-betas.tsv' 'output\nz2016\ctm-K6-iter0-betas.tsv' 'data/counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv' 'output\nz2016\total_variation.png'

python plot_perplexities.py 'output\tcga96\perplexities.tsv' 'output\tcga96\perplexities_boxplot.png' 'output\tcga96\perplexities_lineplot.png'
python plot_betas.py 'output\tcga96\sage-K12-iter0-betas.tsv' 'output\tcga96\ctm-K12-iter0-betas.tsv' 'data/counts.TCGA.WES.SBS-96.tsv' 'output\tcga96\total_variation.png'

python plot_perplexities.py 'output\tcga1536\perplexities.tsv' 'output\tcga1536\perplexities_boxplot.png' 'output\tcga1536\perplexities_lineplot.png'
python plot_betas.py 'output\tcga1536\sage-K18-iter0-betas.tsv' 'output\tcga1536\ctm-K18-iter0-betas.tsv' 'data/counts.TCGA.WES.SBS-1536.tsv' 'output\tcga1536\total_variation_K6.png'
python plot_betas.py 'output\tcga1536\sage-K6-iter0-betas.tsv' 'output\tcga1536\ctm-K6-iter0-betas.tsv' 'data/counts.TCGA.WES.SBS-1536.tsv' 'output\tcga1536\total_variation_K18.png'

