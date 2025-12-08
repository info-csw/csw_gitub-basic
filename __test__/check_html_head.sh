#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="src"

if [ ! -d "$SRC_DIR" ]; then
  echo "❌ Le répertoire '$SRC_DIR' est manquant."
  exit 1
fi

HTML_FILES=$(find "$SRC_DIR" -type f -name "*.html")

if [ -z "$HTML_FILES" ]; then
  echo "❌ Aucun fichier HTML trouvé dans '$SRC_DIR'."
  exit 1
fi

overall_status=0

echo "🔍 Vérification de l'en-tête HTML (lang / title / charset UTF-8) dans chaque fichier"
echo

for FILE in $HTML_FILES; do
  echo "=== Vérification de : $FILE ==="

  file_ok=0

  # lang="fr" ou fr-BE, fr-FR...
  if ! grep -qiE "<html[^>]*lang=[\"']fr([_-][A-Za-z]+)?[\"']" "$FILE"; then
    echo "❌ Attribut lang=\"fr\" (ou fr-BE, fr-FR, ...) absent sur <html>."
    file_ok=1
  fi

  # <title>...</title>
  if ! grep -qi "<title>.*</title>" "$FILE"; then
    echo "❌ Balise <title> manquante ou vide."
    file_ok=1
  fi

  # <meta charset="utf-8">
  if ! grep -qiE "<meta[^>]*charset *= *[\"']utf-8[\"']" "$FILE"; then
    echo "❌ Meta charset UTF-8 manquante. Ajoute par ex. : <meta charset=\"utf-8\">."
    file_ok=1
  fi

  if [ "$file_ok" -ne 0 ]; then
    echo "❌ En-tête HTML incorrect dans : $FILE"
    overall_status=1
  else
    echo "✅ En-tête HTML correct dans : $FILE"
  fi

  echo
done

if [ "$overall_status" -ne 0 ]; then
  echo "❌ Au moins un fichier HTML ne respecte pas les règles d'en-tête (lang / title / charset)."
  exit 1
fi

echo "✅ Tous les fichiers HTML de '$SRC_DIR' ont un en-tête valide (lang / title / charset UTF-8)."
exit 0