#!/usr/bin/env bash
set -euo pipefail

# Step 3: Assembly with SKESA

IN_DIR="../data/clean_fastq"
OUT_DIR="../results/assemblies"

mkdir -p "$OUT_DIR"

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

echo "Detecting cleaned FASTQ pairs in: $IN_DIR"

shopt -s nullglob
R1_FILES=("$IN_DIR"/*_clean.1.fastq.gz)
shopt -u nullglob

# for srr in "${SAMPLES[@]}"; do
#   skesa \
#     --reads \
#       "$IN_DIR/${srr}_clean.1.fastq.gz" \
#       "$IN_DIR/${srr}_clean.2.fastq.gz" \
#     --cores 4 \
#     --min_contig 1000 \
#     --contigs_out "$OUT_DIR/${srr}.fna"
# done

for r1 in "${R1_FILES[@]}"; do
  srr=$(basename "$r1" _clean.1.fastq.gz)
  r2="$IN_DIR/${srr}_clean.2.fastq.gz"

  if [[ ! -f "$r2" ]]; then
    echo "ERROR: Missing mate file for $srr"
    exit 1
  fi

  echo "Assembling genome for sample: $srr"

  skesa \
    --reads \
      "$r1" \
      "$r2" \
    --cores 4 \
    --min_contig 1000 \
    --contigs_out "$OUT_DIR/${srr}.fna"
done

echo "Step 3 completed"