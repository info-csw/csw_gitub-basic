#!/usr/bin/env bash
set -e

FILE="dist/index.html"

if [ ! -f "$FILE" ]; then
  echo "❌ Fichier dist/index.html manquant."
  exit 1
fi

grep -qi "<!doctype html" "$FILE" || { echo "❌ <!DOCTYPE html> manquant."; exit 1; }
grep -qi "<html" "$FILE"        || { echo "❌ <html> manquant."; exit 1; }
grep -qi "<head" "$FILE"        || { echo "❌ <head> manquant."; exit 1; }
grep -qi "<body" "$FILE"        || { echo "❌ <body> manquant."; exit 1; }
grep -qi "</body" "$FILE"       || { echo "❌ </body> manquant."; exit 1; }
grep -qi "</html" "$FILE"       || { echo "❌ </html> manquant."; exit 1; }

echo "✅ Structure HTML minimale OK."
exit 0