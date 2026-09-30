# bash completion for viewme
_viewme() {
  local cur="${COMP_WORDS[COMP_CWORD]}" prev="${COMP_WORDS[COMP_CWORD-1]}"
  case "$prev" in
    --theme) mapfile -t COMPREPLY < <(compgen -W "light dark auto" -- "$cur"); return 0 ;;
    --size)  mapfile -t COMPREPLY < <(compgen -W "1000x820 1280x800 800x600" -- "$cur"); return 0 ;;
  esac
  if [[ "$cur" == -* ]]; then
    mapfile -t COMPREPLY < <(compgen -W "--theme --size --fg --serve --help --version -h -V" -- "$cur")
    return 0
  fi
  if declare -F _filedir >/dev/null 2>&1; then
    _filedir '@(md|markdown|mdown|mkd|txt|MD)'
  else
    mapfile -t COMPREPLY < <(compgen -f -- "$cur")
  fi
}
complete -o filenames -F _viewme viewme
