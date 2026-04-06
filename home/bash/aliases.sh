alias ls="ls --color"
alias l="ls --color -lh"
alias ll="ls --color -lah"

# Avoid VS Code CLI warning about injected Electron Wayland flags.
alias code='env -u NIXOS_OZONE_WL code'

alias h="echo h"
# I hate perf so much for this >:(
alias perfrep="perf report -g 'graph,0.5,caller'"
alias perfrec="perf record -g"

# Zig alias
alias zb="zig build --summary all"
alias zbr="zig build -Doptimize=ReleaseSafe --summary all"

alias wttr="curl https://wttr.in/toulouse"
alias ff="fastfetch"
alias ncdu="ncdu --color dark"
alias xn="nix run github:b3nj5m1n/xdg-ninja"
alias rrc='. $HOME/.bashrc'

alias feh='feh --scale-down'

alias tmp='pushd `mktemp -d`'

alias todo='vim ~/todo.txt'

alias nixos-diff='nix profile diff-closures --profile /nix/var/nix/profiles/system'

function prune_branches() {
    git fetch -p && for branch in $(git for-each-ref --format '%(refname) %(upstream:track)' refs/heads | awk '$2 == "[gone]" {sub("refs/heads/", "", $1); print $1}'); do git branch -D $branch; done
}
