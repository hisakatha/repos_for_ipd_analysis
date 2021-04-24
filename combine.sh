#!/usr/bin/env bash
# E. coli reference (gzipped)
ecoli_ref=GCA_000017985.1_ASM1798v1_genomic.fna.gz
# C. elegans reference (ce11) should be merged into `ce11.fa` beforehand
celegans_ref=/glusterfs/hisakatha/ucsc_ce11/ce11.fa

# Extract and rename E. coli reference
zcat $ecoli_ref | sed -e '1c \>E._coli_REL606' > rel606.fna
# Merge C. elegans reference and E. coli reference
cat $celegans_ref rel606.fna > ce11rel606.fa
samtools faidx ce11rel606.fa
