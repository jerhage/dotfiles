# .bashrc
# Managed in ~/dotfiles/bash; symlinked into $HOME by my.dotfiles.links.

# Source global definitions (NixOS provides PATH and bash completion here).
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

########################################
# environment
########################################
export EDITOR=nvim
export INPUT_METHOD=fcitx          # XMODIFIERS/GTK_IM_MODULE/QT_IM_MODULE come from modules/i18n.nix
export KIME_CONFIG="$HOME/.config/kime/config.yaml"
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/go/bin"
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"
export ERL_AFLAGS="-kernel shell_history enabled"   # shell history inside iex

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

########################################
# aliases
########################################
alias grep='grep --color=auto'
alias ll='ls -l'
alias la='ls -lAtr'
alias cat='bat'
alias ta='tmux a'

alias nr='nixos-rebuild switch --flake ~/nixos-conf --sudo'
alias nn='(cd ~/nixos-conf/ && nvim)'
alias nc='(cd ~/dotfiles/nvim/.config/nvim/ && nvim)'
alias nf='nvim ~/nixos-conf/flake.nix'
alias nfu='nix flake update'
alias ngc='nix store gc'
alias wr="$HOME/dotfiles/scripts/.local/awww/awww_randomize.sh"
alias ss='source ~/.bashrc'

########################################
# functions
########################################
compress() {
    local dir="${1%/}"
    local size
    size=$(du -sb "$dir" | awk '{print $1}')

    tar -cf - "$dir" | pv -s "$size" | zstd -T0 - > "${dir}.tar.zst"
}

decompress() {
    local archive="$1"
    local size
    size=$(stat -c%s "$archive")

    pv -s "$size" "$archive" | zstd -d - | tar -xf -
}

# Wrap yazi so that exiting it cd's to the last directory.
yy() {
    local tmp
    tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
    yazi "$@" --cwd-file="$tmp"
    if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
        builtin cd -- "$cwd" || return
    fi
    rm -f -- "$tmp"
}

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

########################################
# fzf
########################################
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_DEFAULT_OPTS="--color=fg:$fg,bg:$bg,hl:$purple,fg+:$fg,bg+:$bg_highlight,hl+:$purple,info:$blue,prompt:$cyan,pointer:$cyan,marker:$cyan,spinner:$cyan,header:$cyan"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# -- Use fd instead of find --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

_fzf_compgen_path() {
    fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
    fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
    local command=$1
    shift

    case "$command" in
    cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export | unset) fzf --preview "eval 'echo $'{}" "$@" ;;
    ssh) fzf --preview 'dig {}' "$@" ;;
    *) fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
    esac
}

########################################
# prompt and integrations
########################################
eval "$(starship init bash)"
eval "$(fzf --bash)"
eval "$(zoxide init bash)"
