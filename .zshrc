# Enable substitution in the prompt.
setopt prompt_subst

# And colors
autoload -U colors && colors

# Share history between terminals.
setopt share_history

# don't log commands that start with a space
# used for things where you need a password on the command line
setopt HIST_IGNORE_SPACE

# How many commands to store in history
# Histsize: saved in memory; savehist: saved in .zsh_history
HISTSIZE=20000
SAVEHIST=20000

# %m is machine,   1j.%j is: if at least 1 bg job, print bg job count. The ()s
# around the %j are literal ()s to be printed; the %j is the count
# %3 is last three pieces of directory
prompt='$(git_branch_name)%{$fg[red]%} %{$fg[cyan]%}% %(1j.(%j) .)%{$fg[yellow]%}% %4/ %{$reset_color%}%% '

alias bzt='bzl test :go_default_test'
alias bzb='bzl build :go_default_library'

# Advent of Code
export PYTHONPATH="$HOME/code/aoc:$PYTHONPATH"
