if status is-interactive
    # Commands to run in interactive sessions can go here
end

set -gx GPG_TTY (tty)

set -gx PATH /Users/rahul/Library/Python/3.9/bin $PATH

source ~/.config/fish/conf.d/myabbrs.fish
