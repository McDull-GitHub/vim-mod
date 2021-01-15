#!/bin/bash

rm -rf ~/.vimrc ~/.vim &>/dev/null
mv ~/.vimrc.bak ~/.vimrc &>/dev/null
mv ~/.vim.bak ~/.vim &>/dev/null
echo "Done!"
