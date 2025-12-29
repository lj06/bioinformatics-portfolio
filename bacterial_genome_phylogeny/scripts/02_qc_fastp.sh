#!/usr/bin/env bash
set -euo pipefail

# Step 2: Quality control with fastp

IN_DIR="../data/processed_fastq"
OUT_DIR="../data/clean_fastq"
QC_DIR="../results/fastp_qc"

mkdir -p "$OUT_DIR" "$QC_DIR"

# SAMPLES=(
#   SRR1993270
#   SRR1993271
#   SRR1993272
#   SRR2984947
#   SRR2985018
#   SRR3214715
#   SRR3215024
#   SRR3215107
#   SRR3215123
#   SRR3215124
# )

echo "Detecting processed FASTQ pairs in: $IN_DIR"

shopt -s nullglob
R1_FILES=("$IN_DIR"/*.1.fastq.gz)
shopt -u nullglob

# for srr in "${SAMPLES[@]}"; do
#   fastp \
#     -i "$IN_DIR/${srr}.1.fastq.gz" \
#     -I "$IN_DIR/${srr}.2.fastq.gz" \
#     -o "$OUT_DIR/${srr}_clean.1.fastq.gz" \
#     -O "$OUT_DIR/${srr}_clean.2.fastq.gz" \
#     --json "$QC_DIR/${srr}.json" \
#     --html "$QC_DIR/${srr}.html"
# done

for r1 in "${R1_FILES[@]}"; do
  srr=$(basename "$r1" .1.fastq.gz)
  r2="$IN_DIR/${srr}.2.fastq.gz"

  if [[ ! -f "$r2" ]]; then
    echo "ERROR: Missing mate file for $srr"
    exit 1
  fi

  echo "Running fastp for sample: $srr"

  fastp \
    -i "$r1" \
    -I "$r2" \
    -o "$OUT_DIR/${srr}_clean.1.fastq.gz" \
    -O "$OUT_DIR/${srr}_clean.2.fastq.gz" \
    --json "$QC_DIR/${srr}.json" \
    --html "$QC_DIR/${srr}.html"
done

echo "Step 2 completed"