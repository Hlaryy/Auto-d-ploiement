# Auto-déploiement : configuration d'une VM Debian

Script Bash qui configure automatiquement une VM Debian vierge.

## Ce que fait le script

- Met à jour la liste des paquets et installe git, curl, wget, zsh, vim, nano et ca-certificates
- Vérifie que Zsh est bien installé
- Configure Git (nom, e-mail, branche par défaut `main`, éditeur nano)
- Définit Zsh comme shell par défaut
- Installe Oh My Zsh et crée un fichier `.zshrc` avec des alias
- Crée un fichier `.vimrc` de base

## Utilisation

```bash
chmod +x setup.sh
./setup.sh
```

Avant de lancer le script, remplace les variables `name` et `email` au début du fichier par les tiennes.

Déconnecte-toi puis reconnecte-toi à la fin pour utiliser Zsh.
