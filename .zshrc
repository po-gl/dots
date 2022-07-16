# Path Variables {{{
# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
export PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:/Users/porter/Library/Python/3.6/bin:$PATH"

export PATH="/usr/local/opt/ruby/bin:$PATH"
export PATH="$HOME/.gem/ruby/X.X.0/bin:$PATH"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/opt/homebrew/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

export PATH="/usr/local/texlive/2021/bin/universal-darwin:$PATH"

export EDITOR=vim

export CPLUS_INCLUDE_PATH="/usr/local/Cellar/python/3.7.3/Frameworks/Python.framework/Versions/3.7/include/python3.7m/"

export PYTHON_LIBRARY="/usr/local/Frameworks/Python.framework/Versions/3.7/lib/libpython3.7.dylib"
export PYTHON_INCLUDE_DIR="/usr/local/Frameworks/Python.framework/Versions/3.7/Headers/"

# PG Set music alarm environment variable
export MUSIC_ALARM='/Users/porter/Music/Intervals/Libra.mp3'

export PS4='+xtrace $LINENO:'

# }}}
# Aliases {{{

alias vi='nvim'
alias zshconfig="vi ~/.zshrc"

alias cl='clear'

alias python='python3'
alias pip='pip3'

alias pgcopy="tr -d '\n' | pbcopy"

alias ibrew="arch -x86_64 /usr/local/bin/brew"
alias brew="/opt/homebrew/bin/brew"

alias brew-update="brew update; brew upgrade; ibrew update; ibrew upgrade"

# PG Show/Hide files in finder TODO: These should be functions
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# PG Convert all mp3's in current directory back to mp3's w/ 320K bitrate
# to fix itunes not opening mp3's... goddamnit itunes
# This should prabably be a script and not an alias, oh well
# alias convertmp3tomp3='mkdir ./converted; for i in *.mp3; do ffmpeg -i "$i" -acodec libmp3lame -ab:a 320K  "converted/$i"; done; mv converted/* .; rmdir converted/'
# alias convertmp3tomp3automator=' for i in /Users/porter/Music/Downloaded/Converting/*.mp3; do ffmpeg -i "$i" -acodec libmp3lame -ab:a 320K  "/Users/porter/Music/Downloaded/$i"; done'


# }}}
# Custom functions {{{
#
# PG Usage:
# compresspdf [input file] [output file] [screen*|ebook|printer|prepress]
# uses ghostscript and currently doesn't work for big PDFs
#compresspdf(){
#  gs -sDEVICE=pdfwrite -dNOPAUSE -dQUIET -dBATCH -dPDFSETTINGS=/${3:-"screen"} -dCompatibilityLevel=1.4 -sOutputFile="$2" "$1"
#}

# PG encrypt/decrypt with aes-256-cbc
# Note that zip -e another way to encrypt
function encrypt() {
  openssl aes-256-cbc -in $1 -out $2
}
function decrypt() {
  openssl aes-256-cbc -d -in $1 -out $2
}

# File search functions
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }

# }}}
# Plugins {{{
plugins=(git docker npm vi-mode)
# }}}
# General {{{

# VI mode!
bindkey -v

export KEYTIMEOUT=1

# Insert last argument 
vi-yank-arg() {
  NUMERIC=1 zle .vi-add-next
  zle .insert-last-word
}
zle -N vi-yank-arg
bindkey -M vicmd _ vi-yank-arg

# }}}
# Oh My ZSH {{{
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/porter/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"
#ZSH_THEME="pygmalion"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
# plugins=(git) # See section above

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# }}}
# UI {{{

# Right side of prompt
# + VI mode indicator
# + Time stamp
function zle-line-init zle-keymap-select {
    PROMPT_TIMESTAMP="%{$fg[magenta]%}%D{%m/%f}%@%{$reset_color%}"
    VIM_PROMPT="%{$fg_bold[yellow]%} [% NORMAL]%  %{$reset_color%}"
    RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $PROMPT_TIMESTAMP$EPS1"
    #RPS1="${${KEYMAP/vicmd/$VIM_PROMPT}/(main|viins)/} $EPS1"
    zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

RPROMPT="%{$fg[cyan]%}%@%{$reset_color%}"

# }}}
# enable folding  vim:foldmethod=marker:foldlevel=0
