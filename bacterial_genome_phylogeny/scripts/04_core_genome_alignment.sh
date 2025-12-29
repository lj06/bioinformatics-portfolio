#!/usr/bin/env bash
set -euo pipefail

# Step 4: Alignment and phylogeny

ASM_DIR="../results/assemblies"
OUT_DIR="../results/parsnp"

mkdir -p "$OUT_DIR"

parsnp \
  -d "$ASM_DIR" \
  -r ! \
  -o "$OUT_DIR" \
  -p 4 \
  -mmd 0.5

echo "Parsnp finished. Tree file:"
echo "$OUT_DIR/parsnp.tree"
