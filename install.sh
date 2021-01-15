#!/bin/bash
mv ~/.vimrc ~/.vimrc.bak &>/dev/null
mv ~/.vim ~/.vim.bak &>/dev/null
echo "Downloading..."
curl -s -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
cat > ~/.vimrc <<END
call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree' 
Plug 'vim-airline/vim-airline' 
Plug 'vim-airline/vim-airline-themes' 
Plug 'joshdick/onedark.vim' 
Plug 'jiangmiao/auto-pairs' 
Plug 'vim-scripts/SuperTab' 
Plug 'rkulla/pydiction' 
Plug 'luochen1990/rainbow' 
call plug#end()
END

vim -c "PlugInstall" -c "q" -c "q"
rm -rf ~/.vimrc &>/dev/null
curl -s -fLo ~/.vimrc https://raw.githubusercontent.com/McDull-GitHub/vim-mod/master/vimrc
echo "Done!"
