{ pkgs, config, ... }:

{
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    history = {
      size = 5000;
      path = "${config.xdg.dataHome}/zsh/history";
      save = 5000;
      share = true;
      ignoreDups = true;
    };

    shellAliases = {
      ls = "eza -l --icons -a --no-user --group-directories-first";
      vim = "nvim";
      c = "clear";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
    };

    initContent = ''
      # --- your existing .zshrc content starts here ---

      # Powerlevel10k instant prompt
      if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
        source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
      fi

      # macOS brew
      if [[ -f "/opt/homebrew/bin/brew" ]] then
        eval "$(/opt/homebrew/bin/brew shellenv)"
      fi

      # Zinit setup
      ZINIT_HOME="''${XDG_DATA_HOME:-''${HOME}/.local/share}/zinit/zinit.git"
      if [ ! -d "$ZINIT_HOME" ]; then
         mkdir -p "$(dirname $ZINIT_HOME)"
         git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
      fi
      source "''${ZINIT_HOME}/zinit.zsh"

      # TPM setup
      if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
        echo "Installing TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
      fi

      # Plugins
      zinit ice depth=1; zinit light romkatv/powerlevel10k
      zinit light zsh-users/zsh-syntax-highlighting
      zinit light zsh-users/zsh-completions
      zinit light zsh-users/zsh-autosuggestions
      zinit light Aloxaf/fzf-tab

      # Snippets
      zinit snippet OMZP::git
      zinit snippet OMZP::sudo
      zinit snippet OMZP::archlinux
      zinit snippet OMZP::aws
      zinit snippet OMZP::kubectl
      zinit snippet OMZP::kubectx
      zinit snippet OMZP::command-not-found

      # Completions
      autoload -Uz compinit && compinit
      zinit cdreplay -q

      # Powerlevel10k config
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

      # Keybindings
      bindkey -e
      bindkey '^p' history-search-backward
      bindkey '^n' history-search-forward
      bindkey '^[w' kill-region

      # Completion styling
      zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
      zstyle ':completion:*' list-colors "''${(s.:.)LS_COLORS}"
      zstyle ':completion:*' menu no
      zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
      zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

      # Shell integrations
      eval "$(fzf --zsh)"
      eval "$(zoxide init --cmd cd zsh)"

      # Funcitons declarations
      pwdgen() {
        local charset="A-Za-z0-9!@#$%^&*()-_=+[]{};:,.<>?"
        local length=13

        if [ "$1" = "-a" ]; then
          charset="A-Za-z0-9"
          shift
        fi

        if [ -n "$1" ]; then
          length="$1"
        fi

        LC_ALL=C tr -dc "$charset" </dev/urandom | head -c "$length"; echo
      }
      # --- end of .zshrc ---
    '';
  };

  # Better to declare these outside initExtra
  programs.fzf.enable = true;
  programs.zoxide.enable = true;
  programs.eza.enable = true;

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
  ];
}

