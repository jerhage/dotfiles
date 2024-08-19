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

alias ls="eza --color=always --long --git --no-filesize --icons=always"
alias la="eza --color=always --long --git --no-filesize --icons=always --all"
# 'c' for "clean" look
alias lsc="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions"
alias lac="eza --color=always --long --git --no-filesize --icons=always --no-time --no-user --no-permissions --all"
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
eval "$(fzf --bash)"
#
# --- setup fzf theme ---
fg="#CBE0F0"
bg="#011628"
bg_highlight="#143652"
purple="#B388FF"
blue="#06BCE4"
cyan="#2CF9ED"

show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"
# -- Use fd instead of find --
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
	fd --hidden --exclude .git . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
	fd --type=d --hidden --exclude .git . "$1"
}

# Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
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
# Yazi script to wrap the shell and allow cd-ing when exiting Yazi
function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

# Enables shell history within iex
export ERL_AFLAGS="-kernel shell_history enabled"
fastfetch
