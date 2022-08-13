# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Disaable compfix warning
ZSH_DISABLE_COMPFIX=true

# oh-my-zsh
export ZSH="$HOME/.oh-my-zsh" # path to oh-my-zsh installation
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(zsh-syntax-highlighting git autojump rails ruby)
source $ZSH/oh-my-zsh.sh

# personal aliases
alias zshcfg="code ~/.zshrc"
alias zshsrc="source ~/.zshrc"
alias dc="docker-compose"
alias dce="docker-compose exec"
alias dr="dc run rails bundle exec rails"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

eval $(thefuck --alias)
eval "$(rbenv init - zsh)"
