#!/usr/bin/env bash
set -euo pipefail

# Run full bacterial genome phylogeny pipeline
# with --test mode

echo "Starting bacterial genome phylogeny pipeline"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

MODE="full"
RAW_FASTQ_DIR="$PROJECT_ROOT/data/raw_fastq"
RESULTS_DIR="$PROJECT_ROOT/results"


if [[ "${1:-}" == "--test" ]]; then
    MODE="test"
    RAW_FASTQ_DIR="$PROJECT_ROOT/data/sample_fastq"
    RESULTS_DIR="$PROJECT_ROOT/results_test"
    echo "[INFO] Running in TEST mode"
else
    echo "[INFO] Running in FULL mode"
fi

mkdir -p "$RESULTS_DIR"

# Run pipeline
bash "$SCRIPT_DIR/01_split_fastq.sh" "$RAW_FASTQ_DIR" "$RESULTS_DIR"
bash "$SCRIPT_DIR/02_qc.sh"          "$RESULTS_DIR"
bash "$SCRIPT_DIR/03_assembly.sh"    "$RESULTS_DIR"
bash "$SCRIPT_DIR/04_phylogeny.sh"   "$RESULTS_DIR"

echo "Pipeline finished successfully! (${MODE} mode)"
echo "=========================================="
