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

autocmd vimenter * if !argc() | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
set autoread        
if has("autocmd")
      au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

set langmenu=zh_CN.UTF-8
set helplang=cn
set termencoding=utf-8
set encoding=utf8
set fileencodings=utf8,ucs-bom,gbk,cp936,gb2312,gb18030
let mapleader = ","    
set nocompatible       
filetype on            
filetype plugin on     
set noeb               
syntax enable          
syntax on              
set t_Co=256           
set cmdheight=1        
set showcmd            
set scrolloff=3        
set ruler              
set laststatus=2       
set number             
set cursorline         
set virtualedit=block,onemore 
set incsearch          
set hlsearch           
set mouse-=a           
set noeb vb t_vb=      
set autoindent         
set cindent            
set cinoptions=g0,:0,N-s,(0  
set smartindent        
filetype indent on     
set expandtab          
set tabstop=4          
set shiftwidth=4       
set softtabstop=4      
set smarttab           
set wrap               
set iskeyword+=_,$,@,%,#,-
set backspace=2        
set wildmenu           
set completeopt-=preview
set matchtime=1        
set foldmethod=syntax 
set nofoldenable      
set nobackup          
set noswapfile        
set autoread          
set autowrite         
set confirm           

autocmd BufNewFile *.cpp,*.[ch],*.sh,*.rb,*.java,*.py exec ":call SetTitle()" 
func SetTitle() 
    if &filetype == 'sh' 
        call setline(1,"\#!/bin/bash") 
        call append(line("."), "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python")
        call append(line("."),"# -*- coding:utf-8 -*-")
        call append(line(".")+1,"# Author: root  date: ".strftime("%Y-%m-%d"))
        call append(line(".")+2, "") 
        call append(line(".")+3, "") 

    elseif &filetype == 'ruby'
        call setline(1,"#!/usr/bin/env ruby")
        call append(line("."),"# encoding: utf-8")
        call append(line(".")+1, "")
        call append(line(".")+2, "")
    else 
        call setline(1, "/*************************************************************************") 
        call append(line("."), "	> File Name: ".expand("%")) 
        call append(line(".")+1, "	> Author: root") 
        call append(line(".")+2, "	> Mail: root@localhost") 
        call append(line(".")+3, "	> Created Time: ".strftime("%Y-%m-%d")) 
        call append(line(".")+4, " ************************************************************************/") 
        call append(line(".")+5, "")
    endif
    if expand("%:e") == 'cpp'
        call append(line(".")+6, "#include <iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
        call append(line(".")+9, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include <stdio.h>")
        call append(line(".")+7, "")
        call append(line(".")+8, "")
    endif
    if expand("%:e") == 'h'
        call append(line(".")+6, "#ifndef _".toupper(expand("%:r"))."_H")
        call append(line(".")+7, "#define _".toupper(expand("%:r"))."_H")
        call append(line(".")+8, "#endif")
        call append(line(".")+9, "")
    endif
    if &filetype == 'java'
        call append(line(".")+6,"public class ".expand("%:r"))
        call append(line(".")+7,"")
    endif
endfunc 
autocmd BufNewFile * normal G
nnoremap <C-N> :bn<CR>
nnoremap <C-P> :bp<CR>
nmap <Esc><Esc> :qa!<CR>    
nmap <tab><tab> :w<CR>      
map <F3> :NERDTreeToggle<CR>
:autocmd BufRead,BufNewFile *.dot map <F5> :w<CR>:!dot -Tjpg -o %<.jpg % && eog %<.jpg  <CR><CR> && exec "redr!"
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        "exec "!gcc % -o %<"
        "exec "!time ./%<"
        exec "!gcc % -o %< && time ./%< && rm ./%<"
    elseif &filetype == 'cpp'
        "exec "!g++ % -std=c++11 -o %<"
        "exec "!time ./%<"
        exec "!g++ % -std=c++11 -o %< && time ./%< && rm ./%<"
    elseif &filetype == 'java' 
        "exec "!javac %" 
        "exec "!time java %<"
        exec "!javac % && time java %< && rm ./%<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        exec "!time python %"
    elseif &filetype == 'html'
        exec "!firefox % &"
    elseif &filetype == 'go'
        exec "!time go run %"
    elseif &filetype == 'mkd'
        exec "!~/.vim/markdown.pl % > %.html &"
        exec "!firefox %.html &"
    endif
endfunc
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    if &filetype == 'cpp'
        "exec "!g++ % -std=c++11 -g -o %<"
        "exec "!gdb ./%<"
        exec "!g++ % -std=c++11 -g -o %< && gdb ./%<"
    elseif &filetype == 'c'
        "exec "!gcc % -g -o %<"
        "exec "!gdb ./%<"
        exec "!gcc % -g -o %< && gdb ./%<"
    elseif &filetype == 'python'
        exec "!python -m pdb %"
    elseif &filetype == 'go'
        "exec "!go build -o %< %"
        "exec "!gdb ./%<"
        exec "!go build -o %< % && gdb ./%<"
    endif
endfunc
set background=dark
let g:onedark_termcolors=256
colorscheme onedark
let g:airline_theme="onedark"
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:pydiction_location = '~/.vim/plugged/pydiction/complete-dict'
let g:rainbow_active = 1 
