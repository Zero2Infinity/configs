if status is-interactive
    # Commands to run in interactive sessions can go here
end

# GPG TTY
set -gx GPG_TTY (tty)

# PY
set -gx PATH /Users/rahul/Library/Python/3.9/bin $PATH

# pdfcpu
set -gx PATH /Users/rahul/go/bin $PATH

source ~/.config/fish/conf.d/myabbrs.fish
