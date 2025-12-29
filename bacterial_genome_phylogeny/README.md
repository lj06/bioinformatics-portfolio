# Bacterial Genome Phylogeny
## Featured Pipeline: Bacterial Genome Phylogeny

An end-to-end pipeline for bacterial whole-genome analysis, including:

- Paired-end FASTQ preprocessing
- Read quality control (`fastp`)
- De novo genome assembly (`SKESA`)
- Core genome alignment and phylogenetic tree construction (`Parsnp`)

The pipeline is fully script-driven and designed for reproducibility.

---

## Quick Start

### Test mode (recommended)

Run the complete pipeline on a small example dataset:

```bash scripts/run_all.sh --test```

### Full mode

```bash scripts/run_all.sh```


## Repository Structure
.
├── scripts/        # Pipeline scripts (01–04 + run_all.sh)
├── data/           # Input data (raw data ignored; sample data tracked)
├── results/        # Output files (not tracked)
└── README.md