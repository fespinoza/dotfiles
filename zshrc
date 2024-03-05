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
source ~/Dotfiles/zsh/scripts/varner.zsh
source ~/Dotfiles/zsh/scripts/g.zsh

# zstyle ':completion:*:*:git:*' script ~/.git-completion.zsh
# fpath=(~/.zsh/completions $fpath)
# autoload -Uz compinit && compinit

export SHELL=/bin/zsh

export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH=/usr/local/bin:$PATH
export PATH="/Applications/Postgres.app/Contents/Versions/9.5/bin:$PATH"
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/Dotfiles/git:$PATH"
export PATH="$HOME/Dotfiles/bin:$PATH"
export PATH="$HOME/Code/projects/custom-git-scripts/bin:$PATH"
export PATH="$HOME/.mint/bin:$PATH"

export BUNDLESVIM=~/Vim/bundles.vim

export LC_ALL=en_US.utf-8
export LANG="$LC_ALL"

export EDITOR=nvim

eval "$(/opt/homebrew/bin/brew shellenv)"
eval "$(rbenv init -)"
eval "$(direnv hook zsh)"

# tmuxinator
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

export TERM=xterm-256color
fpath=(~/.zsh/bin/wd $fpath)
wd() {
  . $HOME/.zsh/bin/wd/wd.sh
}
eval "$(direnv hook $0)"

# added by travis gem
[ -f /Users/fespinoza/.travis/travis.sh ] && source /Users/fespinoza/.travis/travis.sh

# Add GHC 7.10.2 to the PATH, via https://ghcformacosx.github.io/
export GHC_DOT_APP="/Applications/ghc-7.10.2.app"
if [ -d "$GHC_DOT_APP" ]; then
  export PATH="${HOME}/.local/bin:${HOME}/.cabal/bin:${GHC_DOT_APP}/Contents/bin:${PATH}"
fi
export XDG_CONFIG_HOME=~/Config
export PGHOST=localhost

export PATH="$HOME/.bin:$PATH"
source /Users/fespinoza/.asdf/asdf.sh

# alias swiftlint="mint run swiftlint@0.49.1"
