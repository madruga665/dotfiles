export ZSH="$HOME/.oh-my-zsh"
export PATH=$PATH:/home/madruga665/.local/bin
export NVM_DIR="$HOME/.nvm"
source $ZSH/oh-my-zsh.sh
source <(fzf --zsh)

plugins=(git)

# Init fastfetch
fastfetch -c /home/madruga665/.config/fastfetch/logo.jsonc ; fastfetch

# tmux new
tmux source ~/.tmux.conf
tmux new

# starship theme
eval "$(starship init zsh)"

# Config oh-my-posh
# eval "$(oh-my-posh init zsh --config '/home/madruga665/.config/oh-my-posh/montys.omp.json')"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# place this after nvm initialization!
autoload -U add-zsh-hook

load-nvmrc() {
  local nvmrc_path
  nvmrc_path="$(nvm_find_nvmrc)"

  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version
    nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")

    if [ "$nvmrc_node_version" = "N/A" ]; then
      nvm install
    elif [ "$nvmrc_node_version" != "$(nvm version)" ]; then
      nvm use
    fi
  elif [ -n "$(PWD=$OLDPWD nvm_find_nvmrc)" ] && [ "$(nvm version)" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}

add-zsh-hook chpwd load-nvmrc
load-nvmrc

# Load Angular CLI autocompletion.
# source <(ng completion script)

######################## aliases ########################
alias conectar-fone="~/scripts/conectar-baseus.sh"
alias ls="lsd"
# StayFree Desktop aliases
alias stayfree-start="stayfree-manage.sh start"
alias stayfree-stop="stayfree-manage.sh stop" 
alias stayfree-status="stayfree-manage.sh status"
alias stayfree-logs="stayfree-manage.sh logs"
alias stayfree-restart="stayfree-manage.sh restart"
######################## aliases ########################

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

zinit light zdharma/fast-syntax-highlighting
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-completions

# Preview file content using bat (https://github.com/sharkdp/bat)
export FZF_CTRL_T_OPTS="
  --style full
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind 'focus:transform-header:file --brief {}'"
