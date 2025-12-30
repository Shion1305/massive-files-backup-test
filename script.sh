set -euo pipefail
dir="rand10g_10k"
n=10000
total=$((10 * 1024 * 1024 * 1024)) # 10 GiB
base=$((total / n))                # bytes per file (floor)
rem=$((total - base * n))          # remainder bytes to distribute

mkdir -p "$dir"

for i in $(seq -w 1 "$n"); do
  idx=$((10#$i))
  sz=$base
  if [ "$idx" -le "$rem" ]; then sz=$((base + 1)); fi
  head -c "$sz" /dev/urandom >"$dir/file_$i.bin"
done

find "$dir" -type f -print0 | sort -z | xargs -0 cat | sha256sum | awk '{print $1}'
