#!/usr/bin/env bash
set -euo pipefail

if ! command -v ffmpeg >/dev/null 2>&1; then
  echo "Error: ffmpeg not found. Install with:"
  echo "    brew install ffmpeg"
  exit 1
fi

if ! command -v uv >/dev/null 2>&1; then
  echo "Error: uv not found."
  echo "Install instructions: https://docs.astral.sh/uv/getting-started/installation/"
  echo "Quick install (review the script before running it):"
  echo "    curl -LsSf https://astral.sh/uv/install.sh | sh"
  exit 1
fi

if [[ "$(uname -s)" == "Darwin" && "$(uname -m)" == "arm64" ]]; then
  EXTRA="cpu"
  PLATFORM="Apple Silicon (MPS + CoreML)"
elif command -v nvidia-smi >/dev/null 2>&1 && nvidia-smi -L >/dev/null 2>&1; then
  EXTRA="gpu"
  PLATFORM="NVIDIA CUDA"
else
  EXTRA="cpu"
  PLATFORM="CPU-only"
fi

echo "Detected platform: ${PLATFORM}"
echo "Installing audio-separator[${EXTRA}]..."
uv sync --extra "${EXTRA}"

mkdir -p projects

echo
echo "Verifying acceleration..."
env_output=$(uv run audio-separator --env_info 2>&1 || true)

case "${PLATFORM}" in
  "Apple Silicon (MPS + CoreML)")
    if echo "${env_output}" | grep -q "Apple Silicon MPS/CoreML is available" \
       && echo "${env_output}" | grep -q "CoreMLExecutionProvider available"; then
      echo "  PyTorch MPS:  enabled"
      echo "  ONNX CoreML:  enabled"
    else
      echo "Acceleration verification failed. Full output:"
      echo "${env_output}"
      exit 1
    fi
    ;;
  "NVIDIA CUDA")
    if echo "${env_output}" | grep -q "CUDAExecutionProvider available"; then
      echo "  ONNX CUDA:    enabled"
    else
      echo "CUDA verification failed. Full output:"
      echo "${env_output}"
      exit 1
    fi
    ;;
  *)
    echo "  Running CPU-only. Roformer chains will be slow."
    echo "${env_output}" | grep -E "ExecutionProvider|Torch device" || true
    ;;
esac

echo
echo "stem-lab ready."
echo "Next: drop a track at projects/<song>/source.wav and open Claude Code in this directory."
