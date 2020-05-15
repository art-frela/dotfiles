#!/bin/bash

log() {

  RED='\033[0;31m'
  GREEN='\033[0;32m'
  NC='\033[0m'

  LOG_LEVEL=$1
  case $LOG_LEVEL in
    error)
      COLOR=$RED
      ;;
    info)
      COLOR=$GREEN
      ;;
  esac

  timestamp="$(date +"%Y/%m/%d %H:%M:%S")"
  echo -e "$timestamp [$LOG_LEVEL] $0: ${COLOR}$2${NC}"
}

# Install Brew
if ! [ -x "$(command -v brew)" ]; then
  log info "Installing Brew"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi


BASEDIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Tmux
log info "Configuring tmux"
if [ -f ~/.tmux.conf ] && ! [ -L ~/.tmux.conf ]; then
  if ! [ -d ~/.dotfiles_backup ]; then
    mkdir ~/.dotfiles_backup
  fi
  log info "Backing up old tmux config to ~/.dotfiles_backup/"
  mv ~/.tmux.conf ~/.dotfiles_backup/
fi
if ! [ -L ~/.tmux.conf ]; then
  log info "Linking tmux config"
  ln -s ${BASEDIR}/tmux.conf ~/.tmux.conf
fi
if ! [ -d ~/.tmux/plugins/tpm ]; then
  log info "Linking tmux config"
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# ZSH
log info "Configuring zsh"
if [ -f ~/.zshrc ] && ! [ -L ~/.zshrc ]; then
  if ! [ -d ~/.dotfiles_backup ]; then
    mkdir ~/.dotfiles_backup
  fi
  log info "Backing up old zsh config to ~/.dotfiles_backup/"
  mv ~/.zshrc ~/.dotfiles_backup/
fi
if ! [ -L ~/.zshrc ]; then
  log info "Linking zsh config"
  ln -s ${BASEDIR}/zshrc ~/.zshrc
fi

# # NVim
# ln -s ${BASEDIR}/config ~/.config
