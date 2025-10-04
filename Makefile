default: # Print usage info
	@printf "\033[33minstall-tools:  \033[0minstall nvim and tmux with plugins and copy over gitconfig\n"
	@printf "\033[33minstall:        \033[0minstall packages, copy over configurations, and install plugins\n"
	@printf "\033[33mcopy:           \033[0mcopy configuration to system\n"
	@printf "\033[33mgather:         \033[0mcopy current configuration into this git directory\n"


install: install-brew-bundle copy install-nvim-packer install-tmux-plugin-manager

install-tools: copy-nvim copy-tmux copy-gitconfig install-nvim-packer install-tmux-plugin-manager

copy: copy-bash copy-zsh copy-chunkwmrc copy-docker copy-gitconfig copy-tmux copy-nvim copy-wm copy-vscode copy-omz

gather: get-brew-bundle get-mac-apps get-bash get-zsh get-chunkwmrc get-docker get-gitconfig get-tmux get-nvim get-wm get-vscode get-omz


# Installation rules
install-brew-bundle:
	/usr/local/bin/brew bundle --file=iBrewfile -v
	/opt/homebrew/bin/brew bundle --file=Brewfile -v

install-vundle:
	if [ ! -d ~/.vim/bundle/Vundle.vim ] ; then git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim; fi;
	# Run Vundle Plugin installer
	vim +PluginInstall +qall

install-nvim-packer:
	if [! -d ~/.local/share/nvim/site/pack/packer/start/packer.nvim ] ; then git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim; fi;
	nvim --headless +PackerCompile +PackerInstall +qa

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
	cp .tmux.conf ~/

copy-nvim:
	rm -f ~/.config/nvim/init.vim
	rm -rf ~/.config/nvim/lua/
	cp -R .config/nvim/ ~/.config/nvim/

copy-vim:
	rm -rf ~/.vim/
	cp -R .vim/ ~/.vim/
	cp .vimrc ~/

copy-wm:
	rm -rf ~/.config/yabai/
	rm -rf ~/.config/skhd/
	cp -R .config/yabai/ ~/.config/yabai/
	cp -R .config/skhd/ ~/.config/skhd/

copy-vscode:
	rm -rf ~/.vscode/
	cp -R .vscode/ ~/.vscode/

copy-latexmk:
	cp .latexmkrc ~/

copy-omz:
	cp -R .oh-my-zsh/custom/themes ~/.oh-my-zsh/custom/


# Gather rules
get-brew-bundle:
	/usr/local/bin/brew bundle dump --force --file=iBrewfile
	/opt/homebrew/bin/brew bundle dump --force --file=Brewfile

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
	mkdir .docker/
	cp ~/.docker/config.json .docker/

get-gitconfig:
	cp ~/.gitconfig .

get-tmux:
	cp ~/.tmux.conf .

get-nvim:
	rm -rf .config/nvim/
	cp -R ~/.config/nvim/ .config/nvim/
	rm -rf .config/nvim/plugin/
	rm -rf .config/nvim/undo/

get-vim:
	rm -rf .vim/
	cp -R ~/.vim/ .vim/
	cp ~/.vimrc .

get-wm:
	rm -rf .config/yabai/
	cp -R ~/.config/yabai/ .config/yabai/
	rm -rf .config/skhd/
	cp -R ~/.config/skhd/ .config/skhd/

get-vscode:
	rm -rf .vscode/
	mkdir .vscode/
	cp ~/.vscode/argv.json .vscode/
	cp ~/.vscode/keybindings.json .vscode/
	cp ~/.vscode/settings.json .vscode/

get-latexmk:
	cp ~/.latexmkrc .

get-omz:
	mkdir -p .oh-my-zsh/custom/themes/
	cp -R ~/.oh-my-zsh/custom/themes/ .oh-my-zsh/custom/themes/

