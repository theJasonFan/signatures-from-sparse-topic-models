################################################################################
# SETUP
################################################################################
# Modules
from os.path import join, realpath

# Configuration
OUTPUT_DIR = config['output_dir'] = config.get('output_dir', 'output') # default: output
OUTPUT_DIR = join(OUTPUT_DIR, config.get('run_name', 'default'))
# Directories
DATA_DIR = 'data'
SRC_DIR = 'scripts'

# Files
SBS96_COUNTS = join(DATA_DIR, 'counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv')
SV_COUNTS_RAW = join(DATA_DIR, 'counts.ICGC-BRCA-EU_BRCA_22.Letouze2017.txt')
SV_COUNTS = join(DATA_DIR, 'counts.Letouze2017.reordered.txt')
DATA_PLOT = join(DATA_DIR, 'counts.ICGC-BRCA-EU_BRCA_22.pdf')


################################################################################
# GENRAL RULES
################################################################################
rule all:
    input:
        SV_COUNTS_RAW,
        SBS96_COUNTS,

rule lda:
    input:
        SBS96_COUNTS,
    shell:
        '''
        python benchmark_lda.py --input {input}
        '''

################################################################################
# DOWNLOAD DATA
################################################################################
rule download_sbs96_counts:
    params:
        url='https://obj.umiacs.umd.edu/mutation-signature-explorer/publications/Nik-Zainal2016/processed/counts/counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv'
    output:
        SBS96_COUNTS
    shell:
        'wget -O {output} {params.url}'

rule download_sv_counts:
    params:
        url='https://obj.umiacs.umd.edu/mutation-signature-explorer/publications/Nik-Zainal2016/processed/sv_counts/counts.ICGC-BRCA-EU_BRCA_22.Letouze2017.tsv'
    output:
        SV_COUNTS_RAW
    shell:
        'wget -O {output} {params.url}'
