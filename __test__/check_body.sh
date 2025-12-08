#!/usr/bin/env bash
set -e

FILE="src/index.html"

# vérifier qu'au moins une balise de contenu existe
if ! grep -qiE "<(h1|h2|p)[^>]*>" "$FILE"; then
  echo "❌ Votre page doit contenir au moins un <h1>, <h2> ou <p> (contenu réel)."
  exit 1
fi

echo "✅ Contenu minimal détecté (titre ou paragraphe)."
exit 0