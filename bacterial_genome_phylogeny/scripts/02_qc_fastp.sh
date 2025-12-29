#!/usr/bin/env bash
set -euo pipefail

# Step 2: Quality control with fastp

IN_DIR="../data/processed_fastq"
OUT_DIR="../data/clean_fastq"
QC_DIR="../results/fastp_qc"

mkdir -p "$OUT_DIR" "$QC_DIR"

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

for srr in "${SAMPLES[@]}"; do
  fastp \
    -i "$IN_DIR/${srr}.1.fastq.gz" \
    -I "$IN_DIR/${srr}.2.fastq.gz" \
    -o "$OUT_DIR/${srr}_clean.1.fastq.gz" \
    -O "$OUT_DIR/${srr}_clean.2.fastq.gz" \
    --json "$QC_DIR/${srr}.json" \
    --html "$QC_DIR/${srr}.html"
done
