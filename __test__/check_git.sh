#!/usr/bin/env bash
set -euo pipefail

MIN_COMMITS=2

# Vérifier qu'on est bien dans un dépôt Git
if [ ! -d ".git" ]; then
  echo "ERROR: Ce répertoire ne contient pas de dépôt Git (.git manquant)."
  exit 1
fi

# Si le dépôt est shallow (cas typique GitHub Actions), récupérer tout l'historique
if git rev-parse --is-shallow-repository > /dev/null 2>&1; then
  echo "Info: dépôt shallow détecté, récupération de l'historique complet..."
  git fetch --unshallow >/dev/null 2>&1 || git fetch --depth=50 >/dev/null 2>&1
fi

# Compter les commits
COMMITS=$(git rev-list --count HEAD)

if [ "$COMMITS" -lt "$MIN_COMMITS" ]; then
  echo "ERROR: On attend au moins $MIN_COMMITS commits (template + au moins un commit étudiant)."
  echo "Commits visibles : $COMMITS"
  exit 1
fi

echo "OK: Historique Git avec au moins $MIN_COMMITS commits (commits visibles : $COMMITS)."
exit 0
