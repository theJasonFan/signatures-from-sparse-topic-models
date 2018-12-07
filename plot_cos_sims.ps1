#1536 TCGA
python plot_cos_sim.py `
    --xfile 'output\tcga1536\sage-K6-iter0-betas.tsv' `
    --yfile 'output\tcga1536\ctm-K6-iter0-betas.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'CTM signatures' `
    --title 'SAGE-CTM vs CTM signatures' `
    --output 'output\tcga1536\sage-vs-ctm-sigs.png' `
    --x_is_log --y_is_log

python plot_cos_sim.py `
    --xfile 'output\tcga1536\sage-K6-iter0-betas.tsv' `
    --yfile 'output\tcga1536\sage-K6-iter0-betas.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'SAGE-CTM signatures' `
    --title 'SAGE-CTM vs SAGE-CTM' `
    --output 'output\tcga1536\sage-vs-sage-sigs.png' `
    --x_is_log --y_is_log
    

python plot_cos_sim.py `
    --xfile 'output\tcga1536\ctm-K6-iter0-betas.tsv' `
    --yfile 'output\tcga1536\ctm-K6-iter0-betas.tsv' `
    --xname 'CTM signatures' `
    --yname 'CTM signatures' `
    --title 'CTM vs CTM' `
    --output 'output\tcga1536\ctm-vs-ctm-sigs.png' `
    --x_is_log --y_is_log
    
python plot_cos_sim.py `
    --xfile 'output\tcga1536\sage-K6-iter0-betas.tsv' `
    --yfile 'data\sigAnalyzer-SBS1536.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'SigAnalyzer signatures' `
    --title 'SAGE-CTM vs SigAnalyzer' `
    --output 'output\tcga1536\SAGE-CTM-vs-sigAnalyzer-sigs.png' `
    --x_is_log

#96 Breast cancer TCGA WES
python plot_cos_sim.py `
    --xfile 'output\tcga96\sage-K12-iter0-betas.tsv' `
    --yfile 'output\tcga96\ctm-K12-iter0-betas.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'CTM signatures' `
    --title 'SAGE-CTM vs CTM signatures' `
    --output 'output\tcga96\sage-vs-ctm-sigs.png' `
    --x_is_log --y_is_log

python plot_cos_sim.py `
    --xfile 'output\tcga96\sage-K12-iter0-betas.tsv' `
    --yfile 'output\tcga96\sage-K12-iter0-betas.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'SAGE-CTM signatures' `
    --title 'SAGE-CTM vs SAGE-CTM' `
    --output 'output\tcga96\sage-vs-sage-sigs.png' `
    --x_is_log --y_is_log
    

python plot_cos_sim.py `
    --xfile 'output\tcga96\ctm-K12-iter0-betas.tsv' `
    --yfile 'output\tcga96\ctm-K12-iter0-betas.tsv' `
    --xname 'CTM signatures' `
    --yname 'CTM signatures' `
    --title 'CTM vs CTM' `
    --output 'output\tcga96\ctm-vs-ctm-sigs.png' `
    --x_is_log --y_is_log
    
python plot_cos_sim.py `
    --xfile 'output\tcga96\sage-K12-iter0-betas.tsv' `
    --yfile 'data\cosmic-SBS96.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'COSMIC signatures' `
    --title 'SAGE-CTM vs COSMIC' `
    --output 'output\tcga96\SAGE-CTM-vs-COSMIC-sigs.png' `
    --x_is_log


# NZ2016 Breast cancer TCGA WGS
python plot_cos_sim.py `
    --xfile 'output\nz2016\sage-K6-iter0-betas.tsv' `
    --yfile 'output\nz2016\ctm-K6-iter0-betas.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'CTM signatures' `
    --title 'SAGE-CTM vs CTM signatures' `
    --output 'output\nz2016\sage-vs-ctm-sigs.png' `
    --x_is_log --y_is_log

python plot_cos_sim.py `
    --xfile 'output\nz2016\sage-K6-iter0-betas.tsv' `
    --yfile 'output\nz2016\sage-K6-iter0-betas.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'SAGE-CTM signatures' `
    --title 'SAGE-CTM vs SAGE-CTM' `
    --output 'output\nz2016\sage-vs-sage-sigs.png' `
    --x_is_log --y_is_log
    

python plot_cos_sim.py `
    --xfile 'output\nz2016\ctm-K6-iter0-betas.tsv' `
    --yfile 'output\nz2016\ctm-K6-iter0-betas.tsv' `
    --xname 'CTM signatures' `
    --yname 'CTM signatures' `
    --title 'CTM vs CTM' `
    --output 'output\nz2016\ctm-vs-ctm-sigs.png' `
    --x_is_log --y_is_log
    
python plot_cos_sim.py `
    --xfile 'output\nz2016\sage-K6-iter0-betas.tsv' `
    --yfile 'data\cosmic-SBS96.tsv' `
    --xname 'SAGE-CTM signatures' `
    --yname 'COSMIC signatures' `
    --title 'SAGE-CTM vs COSMIC' `
    --output 'output\nz2016\SAGE-CTM-vs-COSMIC-sigs.png' `
    --x_is_log