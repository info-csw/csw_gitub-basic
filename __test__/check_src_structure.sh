#!/usr/bin/env bash
set -euo pipefail

SRC_DIR="src"

if [ ! -d "$SRC_DIR" ]; then
  echo "❌ Le répertoire '$SRC_DIR' est manquant."
  exit 1
fi

errors=0

########################################
# 1. Vérifier la racine de src/
#    Autoriser uniquement :
#      - .html
#      - .md
#    (plus les sous-répertoires)
########################################

ROOT_FILES=$(find "$SRC_DIR" -maxdepth 1 -type f)

for FILE in $ROOT_FILES; do
  EXT="${FILE##*.}"
  EXT_LOWER=$(echo "$EXT" | tr 'A-Z' 'a-z')

  # Autoriser .html et .md à la racine de src/
  if [[ "$EXT_LOWER" == "html" ]] || [[ "$EXT_LOWER" == "md" ]]; then
    continue
  fi

  echo "❌ Fichier non autorisé à la racine de src/ : $FILE"
  echo "   → Seuls .html et .md sont autorisés à la racine."
  errors=1
done


########################################
# 2. Vérifier que chaque sous-répertoire
#    contient un seul type de fichier :
#    - html / css / js / img
#    - .md ignoré (autorisé partout)
########################################

get_group() {
  local ext_lc="$1"
  case "$ext_lc" in
    html|htm) echo "html" ;;
    css) echo "css" ;;
    js|mjs) echo "js" ;;
    png|jpg|jpeg|gif|svg|webp|avif) echo "img" ;;
    *) echo "" ;; # ignoré
  esac
}

DIRS=$(find "$SRC_DIR" -type d ! -path "$SRC_DIR")

for DIR in $DIRS; do
  FILES=$(find "$DIR" -maxdepth 1 -type f)
  if [ -z "$FILES" ]; then
    continue
  fi

  dir_group=""
  dir_has_group=0
  mixed=0

  for FILE in $FILES; do
    EXT="${FILE##*.}"
    EXT_LOWER=$(echo "$EXT" | tr 'A-Z' 'a-z')

    # .md n'est jamais un "type de répertoire", on ignore
    if [[ "$EXT_LOWER" == "md" ]]; then
      continue
    fi

    GROUP=$(get_group "$EXT_LOWER")

    # Fichier non reconnu (json, txt, etc.) : interdit
    if [[ -z "$GROUP" ]]; then
      echo "❌ Fichier interdit dans '$DIR' : $FILE"
      echo "   → Ce répertoire doit contenir uniquement un type de fichier cohérent (html/css/js/img) + .md éventuels."
      errors=1
      continue
    fi

    if [[ "$dir_has_group" -eq 0 ]]; then
      dir_group="$GROUP"
      dir_has_group=1
    else
      if [[ "$GROUP" != "$dir_group" ]]; then
        mixed=1
        break
      fi
    fi
  done

  if [[ "$mixed" -eq 1 ]]; then
    echo "❌ Le répertoire '$DIR' contient plusieurs types de fichiers incompatibles (html/css/js/img mélangés)."
    errors=1
  fi
done


########################################
# 3. Résultat final
########################################

if [[ "$errors" -ne 0 ]]; then
  echo "❌ L'organisation de 'src/' n'est pas correcte."
  exit 1
fi

echo "✅ Organisation de 'src/' conforme :"
echo "   - Racine : fichiers HTML + fichiers Markdown autorisés"
echo "   - Sous-répertoires : un seul type de fichier (html/css/js/img) + .md autorisés"
exit 0