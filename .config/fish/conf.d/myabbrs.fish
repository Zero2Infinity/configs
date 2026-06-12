# Reload fish configs
abbr -a -- fish-reload 'source ~/.config/fish/config.fish'

# Directory and Files
abbr -a -- l 'eza -lh'
abbr -a -- la 'eza -lha'
abbr -a -- lt 'eza -lht modified'
abbr -a -- ltr 'eza -T -h'
abbr -a -- .. 'cd ../..'
abbr -a -- ... 'cd ../../..'
abbr -a -- .... 'cd ../../../..'
abbr -a -- ws 'cd ~/Documents/ws'

# Git
abbr -a -- gs 'git status'
abbr -a -- gsw 'git switch'
abbr -a -- gco 'git checkout'
abbr -a -- ga 'git add'
abbr -a -- gc 'git commit -S'
abbr -a -- gcm 'git commit -S -m'
abbr -a -- gcam 'git commit -S -a -m'
abbr -a -- gpo 'git push origin'
abbr -a -- gd 'git diff'
abbr -a -- gl 'git pull'
abbr -a -- glo 'git pull origin'
abbr -a -- glg 'git log --all --decorate --oneline --graph'
abbr -a -- gst 'git stash'




