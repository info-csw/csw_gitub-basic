#!/usr/bin/env bash
set -uo pipefail

DIR="src"

# Vérifier que src/ existe
if [ ! -d "$DIR" ]; then
  echo "ERROR: Le répertoire '$DIR' est manquant."
  exit 1
fi

# Récupérer tous les fichiers .html dans src/ (sous-dossiers inclus)
HTML_FILES=$(find "$DIR" -type f -name "*.html")

if [ -z "$HTML_FILES" ]; then
  echo "ERROR: Aucun fichier .html trouvé dans '$DIR'."
  exit 1
fi

echo "Vérification de la validité HTML de tous les fichiers dans '$DIR'..."
echo

overall_status=0

for FILE in $HTML_FILES; do
  echo "=== Vérification de : $FILE ==="
  # On capture les erreurs de tidy dans un fichier temporaire
  tidy -quiet -errors "$FILE" 2> tidy_errors.txt || true

  if [ -s tidy_errors.txt ]; then
    echo "❌ Erreurs trouvées dans $FILE :"
    cat tidy_errors.txt
    echo
    overall_status=1
  else
    echo "✅ $FILE est valide pour tidy."
    echo
  fi
done

rm -f tidy_errors.txt

if [ "$overall_status" -ne 0 ]; then
  echo "ERROR: Au moins un fichier HTML dans '$DIR' est invalide."
  exit 1
fi

echo "✅ Tous les fichiers HTML dans '$DIR' sont considérés comme valides par tidy."
exit 0