# Path Variables {{{

# Setting PATH for Python 3.6
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.6/bin:/Users/porter/Library/Python/3.6/bin:${PATH}"
export PATH

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/usr/local/bin:$PATH"

# PG Set music alarm environment variable
export MUSIC_ALARM='/Users/porter/Music/Intervals/Libra.mp3'

# PG Set computer science environment variable
# export CS_PATH='/Users/porter/Code/CS/'

# }}}
# Aliases {{{

# PG Show/Hide files in finder TODO: These should be functions
alias showfiles='defaults write com.apple.finder AppleShowAllFiles YES; killall Finder /System/Library/CoreServices/Finder.app'
alias hidefiles='defaults write com.apple.finder AppleShowAllFiles NO; killall Finder /System/Library/CoreServices/Finder.app'

# PG Convert all mp3's in current directory back to mp3's w/ 320K bitrate
# to fix itunes not opening mp3's... goddamnit itunes
# This should prabably be a script and not an alias, oh well
# alias convertmp3tomp3='mkdir ./converted; for i in *.mp3; do ffmpeg -i "$i" -acodec libmp3lame -ab:a 320K  "converted/$i"; done; mv converted/* .; rmdir converted/'
# alias convertmp3tomp3automator=' for i in /Users/porter/Music/Downloaded/Converting/*.mp3; do ffmpeg -i "$i" -acodec libmp3lame -ab:a 320K  "/Users/porter/Music/Downloaded/$i"; done'

# PG shorter command to clear panel (I'm addicted to neatness)
alias cl='clear'

alias python='python3'
alias pip='pip3'

alias pgcopy="tr -d '\n' | pbcopy"

# }}}
# Color {{{
export CLICOLOR=1
# }}} 
# Custom commands {{{


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

# }}}
# enable folding  vim:foldmethod=marker:foldlevel=0
