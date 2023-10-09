export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="gozilla"

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
    nohup nautilus -w "$1" > /dev/null 2>&1 &
}


# Path
pathadd "$HOME/.cargo/bin"
pathadd "/usr/local/go/bin"
pathadd "$HOME/.local/bin"
# pathadd "$(ruby -r rubygems -e 'puts Gem.user_dir')"

# Initializing plugins
plugins=(
    git 
    zoxide 
    fast-syntax-highlighting 
    zsh-autocomplete 
    zsh-syntax-highlighting 
    zsh-autosuggestions 
    aws
)

autoload -Uz compinit
# eval "$(zoxide init zsh)"
eval "$(zoxide init zsh --cmd cd)"
eval "$(direnv hook zsh)"
source $ZSH/oh-my-zsh.sh
compinit -i -u
zstyle ':completion:*' completer _expand _expand_alias _complete _correct _ignored _approximate

# Functions and aliases
export FZF_DEFAULT_OPTS="--cycle --no-sort --reverse --border=rounded --header-first --prompt='󰍉 ' --pointer='' --marker='󰆤 '" 

bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete

alias findfiles="fd --type file --type symlink --strip-cwd-prefix | fzf --ansi --prompt='󰘎 ' --header='󰍉 Find file' --preview='bat --style header,grid,numbers --color always {}'"
alias findtext="rg --smart-case --field-match-separator ' ' --line-number --with-filename --no-heading --color=always . | fzf -d ' ' -n 2.. --ansi --prompt='󰘎 ' --header='󰍉 Find Text' --preview 'bat --color=always {1} --highlight-line {2}' --preview-window ~8,+{2}-5"
alias ff=findfiles
alias ft=findtext
alias cd="z"
alias ls="exa --icons"
alias ll="exa -lah --icons"
alias cat="bat"
alias tree="exa -Tah --icons"
alias nvidia="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia"

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
