# 🧪 Tests mis à jour pour `dist/index.html`
## 🧪 tests/check_git.sh (inchangé)

```bash
#!/usr/bin/env bash
set -e

MIN_COMMITS=2

if [ ! -d ".git" ]; then
  echo "❌ Ce répertoire ne contient pas de dépôt Git."
  exit 1
fi

COMMITS=$(git rev-list --count HEAD)

if [ "$COMMITS" -lt "$MIN_COMMITS" ]; then
  echo "❌ On attend au moins ${MIN_COMMITS} commits (template + au moins un commit étudiant)."
  exit 1
fi

echo "✅ Historique Git valide."
exit 0
