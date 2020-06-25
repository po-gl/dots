default: # Print usage info
	@printf "\033[33minstall:        \033[0minstall packages, copy over configurations, and install plugins\n"
	@printf "\033[33mcopy:           \033[0mcopy configuration to system\n"
	@printf "\033[33mgather:         \033[0mcopy current configuration into this git directory\n"


install: install-brew-bundle copy install-vundle install-tmux-plugin-manager

copy: copy-bash copy-zsh copy-chunkwmrc copy-docker copy-gitconfig copy-tmux copy-vim copy-vscode

gather: get-brew-bundle get-mac-apps get-bash get-zsh get-chunkwmrc get-docker get-gitconfig get-tmux get-vim get-vscode


# Installation rules
install-brew-bundle:
	brew bundle --file=Brewfile

install-vundle:
	if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; fi;
	# Run Vundle Plugin installer
	vim +PluginInstall +qall

install-tmux-plugin-manager:
	if [ ! -d ~/.tmux/plugins/tpm ] ; then git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm; fi;
	# Run installer
	~/.tmux/plugins/tpm/scripts/install_plugins.sh


# Copy rules
copy-bash:
	cp .bash_profile ~/
	cp .bashrc ~/

copy-zsh:
	cp .zshrc ~/

copy-chunkwmrc:
	cp .chunkwmrc ~/

copy-docker:
	rm -rf ~/.docker/
	cp -R .docker/ ~/.docker/

copy-gitconfig:
	cp .gitconfig ~/

copy-tmux:
	rm -rf ~/.tmux/
	cp -R .tmux/ ~/.tmux/
	cp .tmux.conf ~/

copy-vim:
	rm -rf ~/.vim/
	cp -R .vim/ ~/.vim/
	cp .vimrc ~/

copy-vscode:
	rm -rf ~/.vscode/
	cp -R .vscode/ ~/.vscode/


# Gather rules
get-brew-bundle:
	brew bundle dump --force

get-mac-apps:
	ls /Applications/ > ./MacOS_apps_list.txt

get-bash:
	cp ~/.bash_profile .
	cp ~/.bashrc .

get-zsh:
	cp ~/.zshrc .

get-chunkwmrc:
	cp ~/.chunkwmrc .

get-docker:
	rm -rf .docker/
	cp -R ~/.docker/ .docker/

get-gitconfig:
	cp ~/.gitconfig .

get-tmux:
	rm -rf .tmux/
	cp -R ~/.tmux/ .tmux/
	cp ~/.tmux.conf .

get-vim:
	rm -rf .vim/
	cp -R ~/.vim/ .vim/
	cp ~/.vimrc .

get-vscode:
	rm -rf .vscode/
	cp -R ~/.vscode/ .vscode/
