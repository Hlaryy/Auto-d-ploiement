#!/bin/bash
set -euo pipefail
name="Prénom Nom"
email="prenom.nom@exemple.com"
omy="${ZSH:-$HOME/.oh-my-zsh}"
echo "Configuration de l'environnement Debian."
echo "Étape 1 : Mise à jour de la liste des paquets."
sudo apt-get update
echo "Étape 2 : Installation des outils."
sudo apt-get install -y \
  git \
  curl \
  wget \
  zsh \
  vim \
  nano \
  ca-certificates

echo "Étape 3 : Vérification de l'installation de Zsh."
if command -v zsh >/dev/null 2>&1
then
echo "Zsh est bien installé."
else
echo "Erreur : Zsh n'a pas été installé."
fi
echo "Étape 4 : Configuration de Git."
git config --global user.name "$name"
git config --global user.email "$email"
git config --global init.defaultBranch main
git config --global core.editor nano
echo "Étape 5 : Faire de Zsh le shell par défaut."
zsh_ins="$(command -v zsh)"
if [ "$SHELL" == "$zsh_ins" ]
then
echo "Zsh est déjà le shell par défaut."
else
chsh -s "$zsh_ins"
echo "Zsh sera le shell par défaut à la prochaine connexion."
fi
echo "Étape 6 : Installation de Oh My Zsh."
if [ ! -d "$omy" ]
then
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
echo "Oh My Zsh est déjà installé."
fi
echo "Étape 7 : Vérification de Oh My Zsh."
if [ -d "$omy" ]
then
echo "Oh My Zsh est bien installé."
else
echo "Erreur : Oh My Zsh n'a pas été installé."
exit 1
fi
echo "Étape 8 : Création de la configuration Zsh et Oh My Zsh."
zshrc="$HOME/.zshrc"
if [ ! -f "$zshrc" ]
then
cat > "$zshrc" <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(
  git
)
source "$ZSH/oh-my-zsh.sh"
alias ll='ls -lah'
alias la='ls -A'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias ..='cd ..'
export EDITOR="nano"
EOF
echo ".zshrc a été créé et configuré."
else
echo ".zshrc existe déjà : il n'est pas écrasé."
fi
echo "Étape 9 : Création du fichier .vimrc."
if [ ! -f "$HOME/.vimrc" ]
then
cat > "$HOME/.vimrc" <<'EOF'
syntax on
set number
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
EOF
echo ".vimrc a été créé."
else 
echo ".vimrc existe déjà : il n'est pas écrasé."
fi
echo "Configuration terminée."
echo "Déconnecte-toi puis reconnecte-toi pour utiliser Zsh."
