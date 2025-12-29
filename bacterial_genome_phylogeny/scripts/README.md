# Pipeline: run_all.sh

This script runs the complete bacterial genome analysis pipeline end-to-end,
including FASTQ preprocessing, quality control, genome assembly, and phylogenetic analysis.

with either in **full mode** (real data) or **test mode** (small sample data for quick validation).

---

## Pipeline Steps

The pipeline consists of the following steps:

1. FASTQ preprocessing
   - Split paired-end reads using `FastQ.split.pl`

2. Quality control
   - Read trimming and filtering using `fastp`

3. Genome assembly
   - De novo assembly using `SKESA`

4. Phylogenetic analysis
   - Core genome alignment and tree construction using `Parsnp`

Each step is implemented as an independent shell script under `scripts/`.

---

## Usage
### 1. Full pipeline run (real data)

bash scripts/run_all.sh


### 2. Test mode pipeline run (sample data)

bash scripts/run_all.sh --test