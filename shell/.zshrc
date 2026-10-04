# ==============================================================================
#  ~/.zshrc — Kabir's Zsh Configuration Entrypoint
# ==============================================================================

# Run fastfetch with random logo on initial shell launch in Kitty (windows & tabs)
# Note: Placed before Powerlevel10k instant prompt to prevent console I/O warnings
if [[ -o interactive && -n "$KITTY_WINDOW_ID" && -z "$FASTFETCH_SHOWN" && -z "$NVIM" && -z "$VIM" ]]; then
    export FASTFETCH_SHOWN=1
    fastfetch
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# Zoxide prompt initialization
eval "$(zoxide init --cmd cd zsh)"

# ------------------------------------------------------------------------------
#  Modular Configurations (~/.config/zsh/)
# ------------------------------------------------------------------------------
ZSH_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"

[[ -f "$ZSH_CONFIG_DIR/env.zsh" ]]       && source "$ZSH_CONFIG_DIR/env.zsh"
[[ -f "$ZSH_CONFIG_DIR/aliases.zsh" ]]   && source "$ZSH_CONFIG_DIR/aliases.zsh"
[[ -f "$ZSH_CONFIG_DIR/functions.zsh" ]] && source "$ZSH_CONFIG_DIR/functions.zsh"
[[ -f "$ZSH_CONFIG_DIR/fzf.zsh" ]]       && source "$ZSH_CONFIG_DIR/fzf.zsh"
[[ -f "$ZSH_CONFIG_DIR/ytd.zsh" ]]       && source "$ZSH_CONFIG_DIR/ytd.zsh"

# Powerlevel10k theme configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
