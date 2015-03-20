# number of lines kept in history
export HISTSIZE=1000
# number of lines saved in the history after logout
export SAVEHIST=1000
# location of history
export HISTFILE=~/.zhistory
# append command to history file once executed
setopt inc_append_history
unalias run-help
autoload run-help
HELPDIR=/usr/local/share/zsh/helpfiles

autoload -U compinit
compinit

# Colors
autoload -U colors
colors
setopt prompt_subst

# Save a smiley to a local variable if the last command exited with success.
local smiley="%(?,%{$fg[green]%}☺%{$reset_color%},%{$fg[red]%}☹%{$reset_color%})"

# Show the relative path on one line, then the smiley.
PROMPT='%{$fg[cyan]%}%~ ${smiley} %{$reset_color%}'

RPROMPT='%{$fg[cyan]%} $(~/Dotfiles/rbenv-version.sh)$(~/Dotfiles/git-cwd-info.sh)%{$reset_color%}'

# Example aliases
source ~/Dotfiles/zsh/aliases
source ~/Dotfiles/zsh/plugins/bundler.zsh
source ~/Dotfiles/zsh/plugins/tmuxinator.zsh

export SHELL=/bin/zsh

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="/Applications/Postgres93.app/Contents/MacOS/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"

export BUNDLESVIM=~/Vim/bundles.vim

export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

export EDITOR=vim

eval "$(rbenv init -)"
eval "$(direnv hook zsh)"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

export TERM=xterm-256color
fpath=(~/.zsh/bin/wd $fpath)
wd() {
  . $HOME/.zsh/bin/wd/wd.sh
}
