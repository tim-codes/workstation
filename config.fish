set -U fish_greeting ""

source $HOME/.local/share/omf/pkg/omf/functions/omf.fish
source /usr/local/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.fish.inc

# Theme
set fish_theme eden

# Make the blue color for directories more readable
set -x LSCOLORS Exfxcxdxbxegedabagacad

set -x PATH "$HOME/bin:/usr/local/bin:$PATH"
set -x PATH "/Applications/Sublime Text.app/Contents/SharedSupport/bin:$PATH"
set -x PNPM_HOME "/Users/tim/Library/pnpm"
set -x PATH "$PNPM_HOME:$PATH"PATH="$PNPM_HOME:$PATH"
set -x PATH "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
set -x PATH "/usr/local/go/bin:$PATH"

set -x GOROOT "/usr/local/go"
set -x GOPATH "$HOME/go"

set -x NVM_DIR "$HOME/.nvm"
set -x KUBE_CONFIG_PATH "$HOME/.kube/config"

alias which="type -p"
alias where="type -a"

# Clear docker container logs <container>
function docker-clear
  echo "" > $(docker inspect --format='{{.LogPath}}' $1)
end

# Remove all stopped containers
function docker-prune-stopped
  docker rm $(docker ps -a -q)
end

function dns:flush
  sudo dscacheutil -flushcache
  sudo killall -HUP mDNSResponder
end

alias python="python3"
alias py="python"
alias tf="terraform"
alias pm="podman"
alias p="pnpm"
alias sf="source ~/.config/fish/config.fish"
alias g="gcloud"
alias mp="mkdir -p"

alias l="ll"
alias ls="exa"
alias ll="exa -l"
alias la="exa -la"

# Git aliases
alias ga='git add'
alias gb='git branch'
alias gbl='gb -l | cat'
alias gblr='gb -lr | cat'
alias gc='git commit -m'
alias gcn='git commit --no-verify -m'
alias gca='git commit -a -m'
alias gcan='git commit -a --no-verify -m'
alias gcl='git clone'
alias gch='git checkout'
function gchh
  set resetting (echo $argv | grep -E 'package.json|pnpm-lock.yaml')
  if $resetting
    echo "manifests changed, running install hook"
    git checkout HEAD -- $argv
  else
    echo "manifests unchanged, skipping install hook"
    git -c core.hooksPath=/dev/null checkout HEAD -- $argv
  end
end
function gd
  git diff --color $argv[1] | diff-so-fancy | bat
end
alias gds="git diff --staged --color | diff-so-fancy | bat"
alias gf='git fetch'
alias gm='git merge'
alias godel='git push --no-verify --delete origin'
alias gp='git pull'
alias gpu='git push'
alias gpun='git push --no-verify'
alias gr='git revert'
alias gs='git status -sb'

# Terraform aliases
alias tfi="tf init"
alias tfpx="tf plan" # base plan
alias tfp="tfpx -lock=false" # plan (no-lock)
alias tfpr="tfpx -lock=false -refresh-only" # refresh
alias tfpl="tfpx -lock=true" # plan (lock)
alias tfpc="tfpx -lock=true -input=false -out=plan.cache" # plan to file
alias tfa="tf apply" # apply
alias tfac="tfa -input=false plan.cache" # apply from file

# bat aliases
alias byaml="bat -l yaml"
alias bjson="bat -l json"

function ip-local
  ifconfig | grep 'broadcast' | awk '{print $2}'
end

function ip-public
  echo "Public IP: $(curl -s ipinfo.io)"
end

# enable IAP ssh tunnel to use numpy on system to increase performance
set -x CLOUDSDK_PYTHON_SITEPACKAGES 1
