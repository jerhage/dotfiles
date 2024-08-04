# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export PATH="$HOME/.local/share/nvim/mason/bin:$PATH"

export EDITOR=nvim
alias nn="home-manager switch --flake $HOME/nix#jh"
alias ihm="nix run nixpkgs#home-manager -- switch --flake $HOME/nix/#$USER"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

eval "$(starship init bash)"
eval "$(zoxide init bash)"
eval "$(direnv hook bash)"

fastfetch
