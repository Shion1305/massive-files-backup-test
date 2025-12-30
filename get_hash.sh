set -euo pipefail
dir="rand10g_10k"
find "$dir" -type f -print0 | sort -z | xargs -0 cat | sha256sum | awk '{print $1}'
