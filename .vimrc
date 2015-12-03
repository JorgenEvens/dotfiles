source ~/.vim/plugins.vim

syntax on
colorscheme monokai
set number
set relativenumber
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround
set expandtab
set mouse=a
set autoindent
set hidden
set backspace=indent,eol,start
set incsearch " Highlight search result as we type
set laststatus=2 " Always show status bar
set nostartofline " Don't reset cursor
set ruler " disable contents of start screen
set noshowmode " Show current mode
set title " set window title
set completeopt=longest,menuone
set colorcolumn=80
set clipboard=unnamed

" Highlight trailing whitespace
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" Disable line wrap
set nowrap

silent exec "!mkdir -p /tmp/.vim"
set backupdir=/tmp/.vim
set scrolloff=5 " Alwasy show 5 lines before and after cursor
set visualbell

" Toggle VIM with ctrl + l
map <C-l> :NERDTreeToggle<CR>

" Close VIM when only NERDTree is open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif

" Use bd when there are open buffers
" nmap :q :if ((len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1) && expand('%') == '')<Bar>exe 'q'<Bar>else<Bar>exe 'bd'<Bar>endif<cr>

let g:jsx_ext_required = 0 " Allow JSX in normal JS filesi
let NERDTreeShowHidden=1

" Git Gutter
let g:gitgutter_enabled = 1

augroup reload_vimrc
    autocmd!
    autocmd BufWritePost $MYVIMRC source $MYVIMRC
augroup END

command! Evim :e $MYVIMRC
cnoreabbrev evim Evim

" CTRL+s save mapping
nmap <C-s> :w<cr>
imap <C-s> <esc>:w<cr>a

" navigate tabs with shift+arrows
map <C-j> :bp<cr>
map <C-k> :bn<cr>

" Use GitFugitive using :git
cnoreabbrev git Git

" Exit INSERT mode on double j
imap jj <Esc>

" Write without using shift
nmap ;q :q<cr>
nmap ;ww :wq<cr>
imap ;ww <esc>:wq<cr>

nmap ;w :w<cr>
imap ;w <Esc>:w<cr>



nmap bd :bd<cr>
nmap bn :bn<cr>

" Go to first character on line
inoremap <Home> <esc>^a<Left>
nnoremap <Home> ^

" check file change every 4 seconds ('CursorHold') and reload the buffer upon detecting change
set autoread
au CursorHold * checktime

" vim-airline plugin
let g:airline_powerline_fonts = 1
let g:Powerline_symbols = 'fancy'
let g:airline_theme='luna'
let g:airline#extensions#tabline#enabled = 1

" Configure editorconfig ( See recommended options https://github.com/editorconfig/editorconfig-vim );
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']
let g:EditorConfig_exec_path = '/usr/local/bin/editorconfig'

" CommandT
" map <C-t> :CommandT<CR>
map <C-p> :CommandT<CR>
map <C-t> :CommandTBuffer<CR>
let g:CommandTWildIgnore=&wildignore . '.git,node_modules/**,custom_modules/**,coverage/**,dist/**'
let g:CommandTIgnoreCase=1
