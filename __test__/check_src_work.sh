#!/usr/bin/env bash
set -euo pipefail

# Extensions autorisées à la racine
ALLOWED_EXTENSIONS=("md" "json" "pdf")
# Fichiers "dotfiles" autorisés
# (tout fichier commençant par . est autorisé d'office)

# Trouver tous les fichiers à la racine (pas de descente)
ROOT_FILES=$(find . -maxdepth 1 -type f | sed 's|^\./||')

BAD_FILES=()

for FILE in $ROOT_FILES; do
  # Ignorer les fichiers dans __test__ et dist
  # (normalement ce test est à la racine, mais on sécurise)
  if [[ "$FILE" == "__test__"* ]] || [[ "$FILE" == "src"* ]]; then
    continue
  fi

  # Accepter tous les fichiers commençant par .
  if [[ "$FILE" =~ ^\. ]]; then
    continue
  fi

  # Récupérer l’extension (sans le nom)
  EXT="${FILE##*.}"

  # Si pas d’extension → fichier interdit
  if [[ "$FILE" == "$EXT" ]]; then
    BAD_FILES+=("$FILE")
    continue
  fi

  # Vérifier si l’extension est autorisée
  allowed=false
  for AEXT in "${ALLOWED_EXTENSIONS[@]}"; do
    if [[ "$EXT" == "$AEXT" ]]; then
      allowed=true
      break
    fi
  done

  if [[ "$allowed" == false ]]; then
    BAD_FILES+=("$FILE")
  fi
done

# Résultat du test
if [[ ${#BAD_FILES[@]} -gt 0 ]]; then
  echo "❌ Fichiers non autorisés trouvés à la racine :"
  for f in "${BAD_FILES[@]}"; do
    echo "   - $f"
  done
  echo "La racine ne doit contenir que : .xxx, *.md, *.json, *.pdf"
  exit 1
fi

echo "✅ Aucun fichier illégal à la racine."
exit 0
