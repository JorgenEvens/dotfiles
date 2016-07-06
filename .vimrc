" vim:foldmethod=marker:foldlevel=0

" Vundle {{{
set nocompatible
filetype off

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'kana/vim-smartinput'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'edkolev/tmuxline.vim'
Plugin 'ervandew/supertab'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'isRuslan/vim-es6'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'pthk/vim-luna'
Plugin 'tpope/vim-surround'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'tpope/vim-commentary'
Plugin 'jason0x43/vim-js-indent'
Plugin 'sickill/vim-pasta'
Plugin 'wavded/vim-stylus'
Plugin 'elzr/vim-json'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'aperezdc/vim-template'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'garbas/vim-snipmate'
Plugin 'scrooloose/nerdcommenter'
Plugin 'rking/ag.vim'
Plugin 'plasticboy/vim-markdown'
Plugin 'niklasl/vim-rdf'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'sheerun/vim-polyglot'
Plugin 'gorodinskiy/vim-coloresque'
call vundle#end()
filetype on
filetype plugin on
" }}}
" Colors {{{
syntax on
colorscheme monokai
" }}}
" Spaces & Tabs {{{
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
" }}}
" UI {{{
set number
set relativenumber
set title " set window title
set hidden " Hide buffers when out of view
set mouse=a " Enable mouse support
set laststatus=2 " Always show status bar
set nostartofline " Don't reset cursor
set ruler " disable contents of start screen
set noshowmode " Show current mode
set completeopt=longest,menuone
set colorcolumn=80 " Shou line at 80 characters
set backspace=indent,eol,start
set scrolloff=5 " Alwasy show 5 lines before and after cursor
set nowrap " Disable line wrap
set visualbell
set cursorline " Highlight active line
set wildmenu " Visual autocomplete menu in command bar
set lazyredraw " Do not redraw during macros
set showmatch " Highlight matching brackets
set foldenable

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
"    let &t_EI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif
" }}}
" Clipboard {{{
if has('unnamedplus')
  set clipboard=unnamedplus
else
  set clipboard=unnamed
endif
" }}}
" Search {{{
set incsearch " Highlight search result as we type
set hlsearch " Highlight all search results in the file
" }}}
" .vimrc {{{
augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

command! Evim :e $MYVIMRC
cnoreabbrev evim Evim
" }}}
" Keymaps {{{
set timeoutlen=500
let mapleader=";"

" navigate tabs with shift+arrows
map <C-j> :bp<cr>
map <C-k> :bn<cr>

" Exit INSERT mode on double j
imap jj <Esc>

" Write without using shift
nmap <leader>q :bd<cr>
nmap <leader>qq :q<cr>
nmap <leader>ww :wq<cr>
imap <leader>ww <esc>:wq<cr>

nmap <leader>w :w<cr>
imap <leader>w <Esc>:w<cr>

" Clear search
nmap <leader>n :noh<cr>

nmap bd :bd<cr>
nmap bn :bn<cr>
nmap bp :bp<cr>

" Go to first character on line
inoremap <Home> <esc>^a<Left>
nnoremap <Home> ^

" Open/close folds
nnoremap <space> za

" Silver Searcher
nmap <leader>ag :Ag<space>-u<space>""<Left>
" }}}
" File changes {{{
" check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" Copy original file to backup
" and overwrite original afterwards.
" Required for webpack-dev-server
set backupcopy=yes
" }}}
" NERDTree {{{
let g:jsx_ext_required = 0 " Allow JSX in normal JS filesi
let NERDTreeShowHidden=1

" Toggle VIM with ctrl + l
map <C-l> :NERDTreeToggle<CR>

" Close VIM when only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" }}}
" GitGutter {{{
let g:gitgutter_enabled = 1

" }}}
" vim-airline {{{
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1
" }}}
" EditorConfig {{{
" Configure editorconfig ( See recommended options https://github.com/editorconfig/editorconfig-vim );
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'
" }}}
" CtrlP {{{
let g:ctrlp_user_command = ['.git', 'cd %s && searchpath']
let g:ctrlp_switch_buffer = 1
" }}}
" Fugitive {{{

" Use GitFugitive using :git
cnoreabbrev git Git

nmap <leader>gs :Gstatus<CR>
nmap <leader>gc :Gcommit<CR>
nmap <leader>gb :Gblame<CR>
nmap <leader>gg :Gbrowse<CR>
" }}}
" vim-template {{{
let g:templates_directory = ['~/.vim/templates']
" }}}
" NERDCommenter {{{
filetype plugin on
let NERDSpaceDelims=1
" }}}
" Silver Searcher / ag.vim {{{
let g:ag_working_path_mode="r" " Search in project root
let g:ag_highlight=1
" }}}
" VIM Multiple Cursors {{{
let g:multi_cursor_use_default_mapping=0
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-x>'
let g:multi_cursor_quit_key='<C-j>'
" }}}
" Backups {{{
silent exec "!mkdir -p /tmp/.vim/{bck,swp}"
set backupdir=/tmp/.vim/bck
set directory=/tmp/.vim/swp
" }}}
" Custom Tabs {{{
filetype plugin on
" }}}
