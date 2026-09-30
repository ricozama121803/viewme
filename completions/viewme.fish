# fish completion for viewme
complete -c viewme -l theme -x -a 'light dark auto' -d 'Color theme'
complete -c viewme -l size -x -a '1000x820 1280x800 800x600' -d 'Window size'
complete -c viewme -l fg -d 'Stay in the foreground'
complete -c viewme -l serve -d 'Only serve and print the URL'
complete -c viewme -s h -l help -d 'Show help'
complete -c viewme -s V -l version -d 'Show version'
complete -c viewme -k -x -a '(__fish_complete_suffix .md .markdown .mdown .mkd .txt)'
