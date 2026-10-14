# ==============================================================================
#  Environment Variables & PATH Configurations
# ==============================================================================

export SHELL=/usr/bin/zsh
export QT_QPA_PLATFORMTHEME=qt5ct

# Node / Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# Rust / Cargo
export PATH="$HOME/.cargo/bin:$PATH"

# User Binaries & Tools
export PATH="$PATH:/home/kabir/.spicetify"
export PATH="/home/kabir/.opencode/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
