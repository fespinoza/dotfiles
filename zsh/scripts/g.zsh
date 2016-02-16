# No arguments: `git status`
# With arguments: acts like `git`
g() {
  if [[ $# > 0 ]]; then
    git $0
  else
    git status
  fi
}

# Complete g like git
compdef g=git
