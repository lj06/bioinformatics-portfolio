#!/usr/bin/env bash
set -euo pipefail

# Step 1: Prepare paired-end FASTQ files

RAW_FASTQ_DIR="../data/raw_fastq"
OUT_DIR="../data/processed_fastq"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mkdir -p "$OUT_DIR"

echo "Detecting raw FASTQ files in: $RAW_FASTQ_DIR"

shopt -s nullglob
RAW_FILES=("$RAW_FASTQ_DIR"/SRR*.fastq)
shopt -u nullglob

for fq in "${RAW_FILES[@]}"; do
  srr=$(basename "$fq" .fastq)
  echo "Processing sample: $srr"

  perl "$SCRIPT_DIR/FastQ.split.pl" \
    "$fq" \
    "$OUT_DIR/$srr"
done

# for srr in "${SAMPLES[@]}"; do
#   perl "$SCRIPT_DIR/FastQ.split.pl" \
#     "$RAW_FASTQ_DIR/${srr}.fastq" \
#     "$OUT_DIR/${srr}"
# done

pigz -9f "$OUT_DIR"/*.fastq
echo "Step 1 completed"