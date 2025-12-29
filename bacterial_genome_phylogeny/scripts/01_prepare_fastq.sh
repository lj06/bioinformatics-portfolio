#!/usr/bin/env bash
set -euo pipefail

# Step 1: Prepare paired-end FASTQ files

RAW_FASTQ_DIR="../data/raw_fastq"
OUT_DIR="../data/processed_fastq"
SCRIPT_DIR="../scripts"

mkdir -p "$OUT_DIR"

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
  perl "$SCRIPT_DIR/FastQ.split.pl" \
    "$RAW_FASTQ_DIR/${srr}.fastq" \
    "$OUT_DIR/${srr}"
done

pigz -9f "$OUT_DIR"/*.fastq
