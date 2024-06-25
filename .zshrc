# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"

#ZSH_THEME="gozilla"
ZSH_THEME="powerlevel10k/powerlevel10k"

function assume-role() {
    OUT=$(aws sts assume-role --role-arn $1 --role-session-name $2)
    if [ "$?" -ne 0 ]; then
        return 1
    fi
    export AWS_ACCESS_KEY_ID=$(echo $OUT | jq -r '.Credentials''.AccessKeyId')
    export AWS_SECRET_ACCESS_KEY=$(echo $OUT | jq -r '.Credentials''.SecretAccessKey')
    export AWS_SESSION_TOKEN=$(echo $OUT | jq -r '.Credentials''.SessionToken')
    export AWS_DEFAULT_REGION=$2;
    return 0
}

function resign-role() {
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_DEFAULT_REGION
}

function pathadd() { 
    case ":${PATH:=$1}:" in 
        *:"$1":*) 
            ;; 
        *) 
            PATH="$1:$PATH" 
            ;; 
    esac; 
}

function open() {
  _folder=${1:-$PWD}
  xdg-open "$_folder"
}


# Path
pathadd "$HOME/.cargo/bin"
pathadd "/usr/local/go/bin"
pathadd "$HOME/.local/bin"
pathadd "${KREW_ROOT:-$HOME/.krew}/bin"
pathadd "/opt/gradle-8.4/bin"
# pathadd "$(ruby -r rubygems -e 'puts Gem.user_dir')"

# Initializing plugins
plugins=(
    git 
    zoxide 
    fast-syntax-highlighting 
    zsh-autocomplete 
    zsh-syntax-highlighting 
    zsh-autosuggestions 
    fzf-tab
    aws
    autoupdate
)

source $ZSH/oh-my-zsh.sh
autoload -Uz compinit
compinit -i -u
eval "$(zoxide init zsh --cmd cd)"
eval "$(direnv hook zsh)"
zstyle ':completion:*' completer _extensions _expand _expand_alias _complete _approximate _correct _ignored 
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
zstyle ':completion:*' menu select

# Functions and aliases
export FZF_DEFAULT_OPTS="--cycle --no-sort --reverse --border=rounded --header-first --prompt='󰍉 ' --pointer='' --marker='󰆤 '" 

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

alias findfiles="fd --type file --type symlink --strip-cwd-prefix | fzf --ansi --prompt='󰘎 ' --header='󰍉 Find file' --preview='bat --style header,grid,numbers --color always {}'"
alias findtext="rg --smart-case --field-match-separator ' ' --line-number --with-filename --no-heading --color=always . | fzf -d ' ' -n 2.. --ansi --prompt='󰘎 ' --header='󰍉 Find Text' --preview 'bat --color=always {1} --highlight-line {2}' --preview-window ~8,+{2}-5"
alias ff=findfiles
alias ft=findtext
alias cd="z"
alias ls="eza --icons"
alias ll="eza -lah --icons"
alias cat="bat"
alias tree="eza -Tah --icons"
alias nvidia="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"
alias kubectx="kubectl ctx"
alias kubens="kubectl ns"
alias vim="nvim"
alias man="batman"
alias clc="clipcopy"
alias clp="clippaste"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/brenozd/.local/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/brenozd/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell zsh --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
source "$HOME/.cargo/env"
