# TP Web1 – Prise en main de Git & page HTML minimale

## 1. Objectifs

1. Cloner le dépôt de l’exercice sur votre machine.
2. Créer/modifier une page `index.html` contenant la structure minimale HTML5.
3. Faire au moins un commit **personnel** et pousser vos modifications sur GitHub.

Des tests d’autograding (GitHub Classroom) vérifieront automatiquement :

- que vous avez bien réalisé au moins un commit après le template ;
- que votre fichier `index.html` contient la structure minimale d’une page HTML5 ;
- que l’en-tête (`<head>`) est bien configuré :
  - attribut `lang="fr"` sur `<html>` (ou variante `fr-BE`, etc.) ;
  - présence d’un `<title>…</title>` ;
  - utilisation de l’encodage UTF-8 via `<meta charset="utf-8">`.

## 2. Consignes

1. **Cloner** le dépôt :
   ```bash
   git clone <URL fournie par GitHub Classroom>
   cd <nom-du-repo>
   ```

2. **Éditer** le fichier index.html (vous pouvez partir du contenu fourni et l’adapter).

3. **Voir l’état** des fichiers :
    ```bash
    git status
    ```

4. **Préparer un commit** :
    ```bash
    git add index.html
    ```

5. **Créer un commit** :
    ```bash
    git commit -m "Complète la structure HTML de base"
    ```

6. **Envoyer sur GitHub** :
    ```bash
    git push
    ```

Vous devez faire plusieurs commits (au moins 2).