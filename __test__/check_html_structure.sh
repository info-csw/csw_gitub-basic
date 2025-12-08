#!/usr/bin/env bash
set -euo pipefail

DIR="src"

# Vérifier que src/ existe
if [ ! -d "$DIR" ]; then
  echo "❌ Le répertoire 'src/' est manquant."
  exit 1
fi

# Trouver tous les fichiers HTML dans src/ (récursif)
HTML_FILES=$(find "$DIR" -type f -name "*.html")

if [ -z "$HTML_FILES" ]; then
  echo "❌ Aucun fichier .html trouvé dans '$DIR'."
  exit 1
fi

overall_status=0

echo "🔍 Vérification de la structure HTML minimale dans tous les fichiers du dossier src/"
echo

for FILE in $HTML_FILES; do
  echo "=== Vérification de : $FILE ==="

  missing=0

  grep -qi "<!doctype html" "$FILE" || { echo "❌ <!DOCTYPE html> manquant."; missing=1; }
  grep -qi "<html" "$FILE"         || { echo "❌ Balise <html> manquante."; missing=1; }
  grep -qi "<head" "$FILE"         || { echo "❌ Balise <head> manquante."; missing=1; }
  grep -qi "<body" "$FILE"         || { echo "❌ Balise <body> manquante."; missing=1; }
  grep -qi "</body" "$FILE"        || { echo "❌ Balise </body> manquante."; missing=1; }
  grep -qi "</html" "$FILE"        || { echo "❌ Balise </html> manquante."; missing=1; }

  if [ "$missing" -eq 1 ]; then
    echo "❌ Structure HTML invalide dans : $FILE"
    echo
    overall_status=1
  else
    echo "✅ Structure minimale OK pour : $FILE"
    echo
  fi
done

if [ "$overall_status" -ne 0 ]; then
  echo "❌ Au moins un fichier HTML ne respecte pas la structure minimale."
  exit 1
fi

echo "✅ Tous les fichiers HTML dans 'src/' respectent la structure minimale."
exit 0