#!/usr/bin/env bash
# HerdLink-ийг Cloudflare Pages руу байршуулах скрипт.
# Хэрэглээ:
#   ./deploy.sh          -> dist/ бэлтгээд байршуулна
#   ./deploy.sh --build  -> зөвхөн dist/ бэлтгэнэ (байршуулахгүй)
set -euo pipefail

cd "$(dirname "$0")"

PROJECT_NAME="herdlink"
FILES=(index.html modules.js module-adapters.js)

rm -rf dist
mkdir -p dist
for f in "${FILES[@]}"; do
  [[ -f "$f" ]] || { echo "Алдаа: $f олдсонгүй" >&2; exit 1; }
  cp "$f" dist/
done
echo "dist/ бэлэн боллоо:"
ls -lh dist

if [[ "${1:-}" == "--build" ]]; then
  exit 0
fi

npx wrangler pages deploy dist --project-name="$PROJECT_NAME"
