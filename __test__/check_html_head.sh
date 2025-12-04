#!/usr/bin/env bash
set -e

FILE="dist/index.html"

if [ ! -f "$FILE" ]; then
  echo "❌ Fichier dist/index.html manquant."
  exit 1
fi

# lang="fr"
if ! grep -qiE "<html[^>]*lang=[\"']fr([_-][A-Za-z]+)?[\"']" "$FILE"; then
  echo "❌ Attribut lang=\"fr\" (ou fr-BE, fr-FR, ...) absent sur <html>."
  exit 1
fi

# <title>...</title>
if ! grep -qi "<title>.*</title>" "$FILE"; then
  echo "❌ Balise <title> manquante ou vide."
  exit 1
fi

# <meta charset="utf-8">
if ! grep -qiE "<meta[^>]*charset *= *[\"']utf-8[\"']" "$FILE"; then
  echo "❌ Meta charset UTF-8 manquante."
  exit 1
fi

echo "✅ En-tête HTML correct (lang / title / charset UTF-8)."
exit 0
