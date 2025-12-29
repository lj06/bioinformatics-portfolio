#!/usr/bin/env bash
set -euo pipefail

# Prepare paired-end FASTQ


# Input directory 
RAW_FASTQ_DIR="../data/raw_fastq"

# Output directory
OUT_DIR="../data/processed_fastq"
mkdir -p "$OUT_DIR"

# SRR sample list
SAMPLES=(
  SRR1993270
  SRR1993271
  SRR1993272
  SRR2984947
  SRR2985018
  SRR3214715
  SRR3215024
  SRR3215107
  SRR3215123
  SRR3215124
)

# Split into paired-end reads
for srr in "${SAMPLES[@]}"; do
  perl FastQ.split.pl \
    "$RAW_FASTQ_DIR/${srr}.fastq" \
    "$OUT_DIR/${srr}"
done
