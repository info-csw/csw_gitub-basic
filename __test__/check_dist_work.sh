#!/usr/bin/env bash
set -e

# Liste les .html à la racine (hors dist et tests)
EXTRA_HTML=$(find . -maxdepth 1 -type f -name "*.html" ! -name ".html")

if [ -n "$EXTRA_HTML" ]; then
  echo "❌ Des fichiers .html ont été trouvés à la racine :"
  echo "$EXTRA_HTML"
  echo "   Toute la page doit se trouver dans dist/index.html."
  exit 1
fi

echo "✅ Aucun fichier .html parasite à la racine."
exit 0
