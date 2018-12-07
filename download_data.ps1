if (-not (Test-Path "data")) { 
    new-item "data" -itemtype directory
 }
iwr -outf "data\counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv" "https://obj.umiacs.umd.edu/mutation-signature-explorer/publications/Nik-Zainal2016/processed/counts/counts.ICGC-BRCA-EU_BRCA_22.SBS-96.tsv"
iwr -outf "data\counts.TCGA.WES.SBS-96.tsv" "https://obj.umiacs.umd.edu/mutation-signature-explorer/mutations/PanCanAtlas/processed/counts/counts.TCGA-BRCA_BRCA_mc3.v0.2.8.SBS-96.tsv"
iwr -outf "data\counts.TCGA.WES.SBS-1536.tsv" "https://obj.umiacs.umd.edu/mutation-signature-explorer/mutations/PanCanAtlas/processed/counts/counts.TCGA-BRCA_BRCA_mc3.v0.2.8.SBS-1536.tsv"
iwr -outf "data\cosmic-SBS96.tsv" "https://obj.umiacs.umd.edu/mutation-signature-explorer/signatures/COSMIC/processed/cosmic-signatures.SBS-96.tsv"
iwr -outf "data\sigAnalyzer-SBS1536.tsv" "https://obj.umiacs.umd.edu/mutation-signature-explorer/signatures/PCAWG/processed/sigAnalyzer-composite_signatures.SBS-1536.tsv"