# User specific environment
PATH=$HOME/.local/bin:$HOME/.local/npm/bin:$HOME/opt/bin:$PATH

# Rust's way of doing things
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

export PATH
