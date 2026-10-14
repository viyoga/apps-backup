# ==============================================================================
#  FZF Integration & Keybindings
# ==============================================================================

# Source modern FZF shell integration (keybindings + completions)
eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS_FILE="$HOME/.config/shell/fzf-colors"

# FZF navigation with Alt+vim keys
export FZF_DEFAULT_OPTS="$FZF_DEFAULT_OPTS --bind='alt-j:down,alt-k:up,alt-h:preview-up,alt-l:preview-down'"

# Fuzzy find file preview with bat and open in nvim
f() {
  local file
  file=$(fzf -m --height=60% --preview="bat --color=always {}") || return
  nvim ${(f)file}
}

# Override fzf Alt+C to use zoxide cd instead of builtin cd
fzf-cd-widget() {
  setopt localoptions pipefail no_aliases 2> /dev/null
  local dir="$(
    FZF_DEFAULT_COMMAND=${FZF_ALT_C_COMMAND:-} \
    FZF_DEFAULT_OPTS=$(__fzf_defaults "--reverse --walker=dir,follow,hidden --scheme=path" "${FZF_ALT_C_OPTS-} +m") \
    FZF_DEFAULT_OPTS_FILE='' $(__fzfcmd) < /dev/tty)"
  if [[ -z "$dir" ]]; then
    zle redisplay
    return 0
  fi
  zle push-line
  BUFFER="cd ${(q)dir:a}"
  zle accept-line
  local ret=$?
  unset dir
  zle reset-prompt
  return $ret
}
zle -N fzf-cd-widget

# Keybindings: Alt+P for files, Alt+R for history (instead of Ctrl+T, Ctrl+R)
bindkey '^T' ''
bindkey -M emacs '\ep' fzf-file-widget
bindkey '^R' ''
bindkey -M emacs '\er' fzf-history-widget

# History prefix search: type a command prefix and hit Ctrl+P / Ctrl+N to cycle matching commands
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# ------------------------------------------------------------------------------
#  fzf-tab: Interactive Tab Completion with Rich Previews
# ------------------------------------------------------------------------------
if [[ -f "$HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh" ]]; then
  source "$HOME/.config/zsh/plugins/fzf-tab/fzf-tab.plugin.zsh"

  # Disable default completion menu so fzf-tab handles it
  zstyle ':completion:*' menu no

  # Switch completion groups using '<' and '>'
  zstyle ':fzf-tab:*' switch-group '<' '>'

  # Trigger continuous completion when pressing '/'
  zstyle ':fzf-tab:*' continuous-trigger '/'

  # Directory preview on `cd <Tab>` and `z <Tab>` using eza
  zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always --icons $realpath'
  zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always --icons $realpath'

  # Process kill previews
  zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
  zstyle ':fzf-tab:complete:(kill|pkill):*' fzf-flags '--preview-window=down:3:wrap'

  # Systemctl command previews
  zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'
fi
