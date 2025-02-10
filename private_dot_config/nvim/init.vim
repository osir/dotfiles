""""""""""""""""""""""""""""""""
"    _      _ __        _      "
"   (_)__  (_) /_ _  __(_)_ _  "
"  / / _ \/ / __/| |/ / /  ' \ "
" /_/_//_/_/\__(_)___/_/_/_/_/ "
"                              "
""""""""""""""""""""""""""""""""

set nocompatible


"""""""""""
" Plugins "
"""""""""""

" Automatically install vim-plug if not installed
if has('nvim')
    if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
        silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    let plugin_dir = '~/.local/share/nvim/plugged'
else
    if empty(glob('~/.vim/autoload/plug.vim'))
        silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
            \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
    let plugin_dir = '~/.vim/plugged'
endif

function! Cond(cond, ...)
    let opts = get(a:000, 0, {})
    return a:cond ? opts : extend(opts, {'on': [], 'for': [] })
endfunction

call plug#begin(plugin_dir)

Plug 'ellisonleao/gruvbox.nvim'

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'tpope/vim-afterimage'
Plug 'tpope/vim-characterize'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'

Plug 'majutsushi/tagbar'
Plug 'fatih/vim-go'                "
Plug 'vim-latex/vim-latex'         "
Plug 'WolfgangMehner/perl-support' "
Plug 'itchyny/lightline.vim'       " Status bar
Plug 'Yggdroot/indentLine'         " Display thin lines per indentation level
Plug 'jceb/vim-orgmode'            "
Plug 'airblade/vim-gitgutter'      " Shows a git diff in vim
Plug 'myusuf3/numbers.vim'         " Relative line numbers

Plug 'elzr/vim-json', { 'for': 'json' }

Plug 'Shougo/deoplete.nvim', Cond(has('nvim'), { 'do': ':UpdateRemotePlugins' })
Plug 'zchee/deoplete-jedi',  Cond(has('nvim'), { 'for': 'python' })
Plug 'zchee/deoplete-clang', Cond(has('nvim'), { 'for': ['c', 'cpp'] })
Plug 'Shougo/neco-vim',      Cond(has('nvim'), { 'for': 'vim' })


Plug 'rust-lang/rust.vim',   Cond(has('nvim'), { 'for': 'rust' })
Plug 'racer-rust/vim-racer', Cond(has('nvim'), { 'for': 'rust' })
let g:rustfmt_autosave = 1

Plug 'kannokanno/previm'
let g:previm_opem_cmd = 'qutebrowser'
augroup PrevimSettings
    autocmd!
    autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown
augroup END

call plug#end()


""""""""""""
" Settings "
""""""""""""

let mapleader = ' '

" Visual
syntax on
set ruler
set number
set cursorline
set showcmd
set showmode
set showmatch
set laststatus=2
set colorcolumn=81
highlight ColorColumn ctermbg=5
set background=dark
colorscheme gruvbox
set list
if &encoding != 'utf-8'
    set listchars=tab:>\ ,trail:-,nbsp:+,precedes:<,extends:>
else
    set listchars=eol:¬,tab:»\ ,trail:·,nbsp:⬚,precedes:⍇,extends:⍈
endif

" Indentation
set modeline
set autoindent
set smartindent
set breakindent
set expandtab
set tabstop=4
set softtabstop=1
set shiftwidth=4

" Search
set ignorecase
set smartcase
set hlsearch
set incsearch

" Navigation
set mouse=a
set scrolloff=10
set sidescrolloff=5
set backspace=indent,eol,start

" Other
set wildmenu
set nobackup
set nowritebackup
set clipboard=unnamed,unnamedplus
set nrformats=hex,bin
set history=1000
set tabpagemax=50

" Delete comment character when joining lines
set formatoptions+=j

" Spelling
set spelllang=en
autocmd FileType gitcomit  setlocal spell
autocmd FileType plaintext setlocal spell
autocmd FileType markdown  setlocal spell
let g:guesslang_langs = [ 'en_US', 'de_CH' ]

""""""""
" Keys "
""""""""

function! ColorColumnToggle()
    if &colorcolumn == 81
        set colorcolumn=121
        echo 'Column: 120'
    elseif &colorcolumn == 121
        set colorcolumn=0
        echo 'Column: OFF'
    else
        set colorcolumn=81
        echo 'Column:  80'
    endif
endfunction

nnoremap <F2> :call ColorColumnToggle()<CR>
nnoremap <F3> :NERDTreeToggle<CR>
nnoremap <F4> :GitGutterBufferToggle<CR>
nnoremap <F5> :set wrap!<CR>
nnoremap <F6> :TagbarToggle<CR>
nnoremap <F9> :!%:p<CR>  " execute the current file

" Use <C-L> to reset hlsearch highlighting
if maparg('<C-L>', 'n') ==# ''
    nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif


" vim:set ft=vim et sw=4
