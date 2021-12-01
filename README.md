[![DOI](https://zenodo.org/badge/361056909.svg)](https://zenodo.org/badge/latestdoi/361056909)

Repositories for the IPD analyses in C. elegans as submodules

# System requirements

Please note that an analysis for a typical PacBio SMRT-seq data requires a lot of RAM.

## Tested environment

Scripts and source codes in this repository were executed under the following environment:

- OS: CentOS6 (6.10) or CentOS7 (7.8.2003)
- RAM: approx. 500 GB
- glibc: v2.12 on CentOS6, v2.17 on CentOS7, or a custom install of glibc v2.23 for some scripts
- GNU Make v4.3
- Rust v1.46.0
- R v4.0.2 and the following packages:
  - data.table (1.13.0)
  - ggplot2 (3.3.2)
  - hdf5r (1.3.2)
  - fst (0.9.2)
  - cowplot (1.0.0)
  - Biostrings (2.56.0)
- bedtools (v2.28.0)
- SeqKit (v0.10.1)
- samtools (1.11)
- MEME Suite (5.1.1)
- Job scheduler: Oracle Grid Engine (6.2u7)

# Installation guide

- `git clone --recursive https://github.com/hisakatha/repos_for_ipd_analysis.git`
- For the tools written in Rust, please set up a Rust environment.
Then, please `cargo build --release` and find the executables at `target/release` directory,
or you can install them by `cargo install --path .`
at the programs' root directories.

# How to reproduce

## Prepare reference sequences

The custom reference sequence in this study can be generated with `combine.sh`
after downloading C. elegans reference (UCSC ce11) and E. coli reference (GenBank CP000819.1)

## Prepare SMRT sequencing data

Our sequence data are available under the study accession PRJNA724924 of Sequence Read Archive (SRA)

`*.subreads.bam` is essential. Other files are useful for trying another parameter set for processing.

## Process SMRT sequencing data for each sample

In `ipd_analysis_on_ce11rel606` submodule (directory), move to the following directory and call `./run_pbsmrtpipe.sh`

- replicate 1/WGA: `jun2018_ab_pcr_vc2010_op50_all_alignments` and `jun2018_ab_pcr_vc2010_op50_no_chunk`
- replicate 2/WGA: `jun2018_cd_pcr_vc2010_all_alignments` and `jun2018_cd_pcr_vc2010_no_chunk`
- replicate 1/native: `jun2018_k_nopcr_vc2010_op50_all_alignments` and `jun2018_k_nopcr_vc2010_op50_no_chunk`
- replicate 2/native: `jun2018_l_nopcr_vc2010_all_alignments` and `jun2018_l_nopcr_vc2010_no_chunk`

`PD2182*` directories are for internal data.

You may have to regenerate `*.subreads.xml` using `./register_subreads.sh` or `dataset` command in the SMRT Link Commandline tools.

After the call `./run_pbsmrtpipe.sh`, call `make -f ../samples.makefile` at the sample directory.

In addition, at `*_all_alignments` directories, call `make -f ../samples.makefile mapq_comp_csv`

## Process data from all the samples

Move to `jun2018_analysis_high_mapq`, and then, call `./init.sh` and `make`
