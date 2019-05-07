default: copy

install: install-brew-bundle copy-bash copy-chunkwmrc copy-docker copy-gitconfig copy-tmux copy-vim copy-vimrc copy-vscode

copy: copy-bash copy-chunkwmrc copy-docker copy-gitconfig copy-tmux copy-vim copy-vimrc copy-vscode

gather: get-brew-bundle get-bash get-chunkwmrc get-docker get-gitconfig get-tmux get-vim get-vimrc get-vscode


# Installation rules
install-brew-bundle:
	brew bundle --file Brewfile


# Copy rules
copy-bash:
	cp .bash_profile ~/
	cp .bashrc ~/

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

copy-vim:
	rm -rf ~/.vim/
	cp -R .vim/ ~/.vim/

copy-vimrc:
	cp .vimrc ~/

copy-vscode:
	rm -rf ~/.vscode/
	cp -R .vscode/ ~/.vscode/


# Gather rules
get-brew-bundle:
	brew bundle dump --force

get-bash:
	cp ~/.bash_profile .
	cp ~/.bashrc .

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

get-vim:
	rm -rf .vim/
	cp -R ~/.vim/ .vim/

get-vimrc:
	cp ~/.vimrc .

get-vscode:
	rm -rf .vscode/
	cp -R ~/.vscode/ .vscode/
