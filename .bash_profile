# Used to consolidate .bash_profile and .bashrc
if [ -f $HOME/.bashrc ]; then
        source $HOME/.bashrc
fi

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

