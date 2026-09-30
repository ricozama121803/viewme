#!/usr/bin/env bash
# Install viewme, its man page and shell completions.
# Usage: ./install.sh [prefix]     (default: ~/.local, or /usr/local when run as root)
#        ./install.sh --uninstall [prefix]
set -euo pipefail
here="$(cd "$(dirname "$0")" && pwd)"

uninstall=0
if [ "${1:-}" = "--uninstall" ]; then uninstall=1; shift; fi

if [ -n "${1:-}" ]; then prefix="$1"
elif [ "$(id -u)" -eq 0 ]; then prefix=/usr/local
else prefix="$HOME/.local"; fi

bin="$prefix/bin/viewme"
man="$prefix/share/man/man1/viewme.1"
bash_c="$prefix/share/bash-completion/completions/viewme"
zsh_c="$prefix/share/zsh/site-functions/_viewme"
fish_c="$prefix/share/fish/vendor_completions.d/viewme.fish"
[ "$prefix" = "$HOME/.local" ] && fish_c="${XDG_CONFIG_HOME:-$HOME/.config}/fish/completions/viewme.fish"

if [ "$uninstall" -eq 1 ]; then
  rm -f "$bin" "$man" "$bash_c" "$zsh_c" "$fish_c"
  echo "removed viewme from $prefix"
  exit 0
fi

command -v python3 >/dev/null 2>&1 || { echo "viewme needs python3 (3.8+)" >&2; exit 1; }

install -Dm 755 "$here/viewme" "$bin"
install -Dm 644 "$here/man/viewme.1" "$man"
install -Dm 644 "$here/completions/viewme.bash" "$bash_c"
install -Dm 644 "$here/completions/_viewme" "$zsh_c"
install -Dm 644 "$here/completions/viewme.fish" "$fish_c"

echo "installed:"
printf '  %s\n' "$bin" "$man" "$bash_c" "$zsh_c" "$fish_c"
echo
case ":$PATH:" in *":$prefix/bin:"*) ;; *) echo "note: add $prefix/bin to your PATH" ;; esac
echo "bash: completion loads automatically in new shells (needs the bash-completion package)."
echo "zsh:  add this to ~/.zshrc before compinit:  fpath=($prefix/share/zsh/site-functions \$fpath)"
echo "man:  try 'man viewme'"
command -v google-chrome chromium chromium-browser brave-browser microsoft-edge vivaldi >/dev/null 2>&1 \
  || echo "note: no Chromium-based browser found; viewme will open your default browser instead of a popup."
