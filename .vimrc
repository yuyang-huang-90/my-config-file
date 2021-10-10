"====== BASIC CONFIG========
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

" Don't use Ex mode, use Q for formatting
map Q gq

"vim mode
set backspace=2
"encoding
set fenc=utf-8
set enc=utf-8
set fencs=utf-8,shift_jis,iso-2022-jp,gbk,euc-jp
"indent
set autoindent
set cindent
"tab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set smarttab
" Show matching brackets.
set showmatch
" Do case insensitive matching
set ignorecase
" Do smart case matching
set smartcase
" Incremental search
set incsearch
" hl the matched word
set hlsearch
" Automatically save before commands like :next and :make
set autowrite
" Enable mouse usage (all modes
"set mouse=a
"noback
set nobackup
"number
set number
"ruler
set ru
"status line
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%04l,%04v][%p%%]\ [LEN=%L]
set laststatus=2
"tab completion
"set wildmode=list:full


"ctags set tag=tags set autochdir

"word warp
set tw=79

" update time
set updatetime=2000

"fix the hotkey delay problem
set timeout timeoutlen=5000 ttimeoutlen=100

"adjust filetype recongnization
au BufRead {*.log,message} set ft=messages
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} set ft=ruby
"au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
au BufRead,BufNewFile {COMMIT_EDITMSG} set ft=gitcommit

"set indent
autocmd FileType yaml       setl ts=2 sts=2 sw=2 et
autocmd FileType ruby,eruby setl ts=2 sts=2 sw=2 et
autocmd FileType tex        setl ts=2 sts=2 sw=2 et
autocmd FileType html       setl ts=2 sts=2 sw=2 et
autocmd FileType css        setl ts=2 sts=2 sw=2 et
autocmd FileType less       setl ts=2 sts=2 sw=2 et
autocmd FileType python     setl ts=4 sts=4 sw=4 et
autocmd FileType make       setl ts=8 sts=8 sw=8 noet
autocmd FileType conf       setl ts=8 sts=8 sw=8 noet
autocmd FileType gitconfig  setl noet
autocmd FileType javascript setl ts=2 sts=2 sw=2 et
autocmd FileType haskell    setl ts=8 sts=4 sw=4 sta et sr nojs

"fold
set foldmethod=indent
set foldenable
set foldlevel=100 "do not auto fold anythin
set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix
nmap <Space> za

" Automatically change the working path to the path of the current file
"autocmd BufNewFile,BufEnter * silent! lcd %:p:h

"smart tab mapping
map <D-1> 1gt
map <D-2> 2gt
map <D-3> 3gt
map <D-4> 4gt
map <D-5> 5gt
map <D-6> 6gt
map <D-7> 7gt
map <D-8> 8gt
map <D-9> 9gt
map <D-t> :tabnew<CR>
map <D-w> :tabclose<CR>
nmap <C-n> gt
nmap <C-p> gT

"key binding
"emacs style key
imap <C-d> <Del>
imap <C-e> <Esc>A
imap <C-a> <Esc>I
imap <C-f> <Right>
imap <C-b> <Left>
"AutoClose
imap ""> ""<ESC>i
imap ''> ''<ESC>i
imap ()> ()<ESC>i
imap {}> {}<ESC>i
imap []> []<ESC>i
imap <>> <><ESC>i
imap $$> $$<ESC>i
imap %%> %%<ESC>i<SPACE><SPACE><ESC>i
imap (<CR> ()><CR><ESC>==O
imap {<CR> {}><CR><ESC>==O
imap [<CR> []><CR><ESC>==O
imap <C-l> <CR><ESC>ko
"change focus
imap <F2> <ESC>zzko
" replace word with paste item
map <C-j> cw<c-r>0<ESC>b
"move
nmap mp :bp<CR>
nmap mn :bn<CR>
map  <Leader>f :FZF<CR>
map  <Leader>l :Lines<CR>
map  <Leader>b :Buf<CR>
map  <Leader>a :Ag<CR>
map  <Leader>r :Rg<CR>
autocmd WinEnter * if exists("t:NERDTreeBufName") && winnr("$") == 1 &&bufwinnr(t:NERDTreeBufName) != -1 | q | endif
cmap NT<CR> NERDTree<CR>
cmap NTC<CR> NERDTreeClose<CR>
" tagbar setting and key bind
cmap TB<CR> TagbarToggle<CR>
cmap TBC<CR> TagbarClose<CR>

"quick close
nnoremap <C-k> :close<CR>
inoremap <C-k> :close<CR>
vnoremap <C-k> :close<CR>
snoremap <C-k> :close<CR>
xnoremap <C-k> :close<CR>
cnoremap <C-k> :close<CR>
onoremap <C-k> :close<CR>
lnoremap <C-k> :close<CR>
tnoremap <C-k> :close<CR>

"quick esc
nnoremap <C-c> <Esc>
inoremap <C-c> <Esc>
vnoremap <C-c> <Esc>
snoremap <C-c> <Esc>
xnoremap <C-c> <Esc>
cnoremap <C-c> <Esc>
onoremap <C-c> <Esc>
lnoremap <C-c> <Esc>
tnoremap <C-c> <Esc>

"======END OF BASIC CONFIG========




"====== END OF EXTRA CONFIG========

"====== VIM EXTERNAL PLUGINS========
" requried for vundle but no need for vim-plugin
filetype off
if isdirectory(expand('~/.vim/plugged'))
  call plug#begin('~/.vim/plugged')

  Plug 'Lokaltog/vim-easymotion'
  Plug 'tpope/vim-surround'
  Plug 'scrooloose/nerdtree'
  Plug 'tpope/vim-pathogen'
  Plug 'junegunn/fzf', { 'dir': '~/.fzf' }
  Plug 'junegunn/fzf.vim'
  Plug 'tpope/vim-commentary'
  Plug 'airblade/vim-gitgutter'
  Plug 'majutsushi/tagbar'
  Plug 'vim-scripts/L9'
  Plug 'vim-scripts/ShowTrailingWhitespace'
  Plug 'vim-scripts/Tabular'
  Plug 'Yggdroot/indentLine'
  Plug 'airblade/vim-rooter'
  Plug 'tpope/vim-fugitive'
  Plug 'Valloric/YouCompleteMe'
  Plug 'rdnetto/YCM-Generator', { 'branch': 'stable'}
  Plug 'lervag/vimtex'
  Plug 'google/vim-maktaba'
  Plug 'google/vim-codefmt'
  " Also add Glaive, which is used to configure codefmt's maktaba flags. See
  " `:help :Glaive` for usage.
  Plug 'google/vim-glaive'

  call plug#end()

endif

let g:tex_flavor = 'latex'
let g:tex_flavor = 'latex'

"ycm
nmap <C-\>s :YcmCompleter GoToReferences<CR>
nmap <C-\>g :YcmCompleter GoToDefinition<CR>
nmap <C-\>d :YcmCompleter GoToDeclaration<CR>
nmap <C-\>f :YcmCompleter GoToImprecise<CR>
nmap <C-\>e :YcmCompleter GoToSymbol
nmap <C-\>h :YcmCompleter GoToInclude<CR>
" nerd tree setting and key bind
autocmd WinEnter * if exists("t:NERDTreeBufName") && winnr("$") == 1 &&bufwinnr(t:NERDTreeBufName) != -1 | q | endif
cmap NT<CR> NERDTree<CR>
cmap NTC<CR> NERDTreeClose<CR>
nmap mp :bp<CR>
nmap mn :bn<CR>
" tagbar setting and key bind
cmap TB<CR> TagbarToggle<CR>
cmap TBC<CR> TagbarClose<CR>

"fzf
map  <Leader>f :FZF<CR>
map  <Leader>l :Lines<CR>
map  <Leader>b :Buf<CR>
map  <Leader>a :Ag<CR>
map  <Leader>r :Rg<CR>

augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
  autocmd FileType rust AutoFormatBuffer rustfmt
  autocmd FileType vue AutoFormatBuffer prettier
augroup END

" turn on indentation
filetype plugin indent on
"syntax
syntax on

"====== END OF VIM PLUGIN========

"====== EXTRA CONFIG========
let VIMCONFIG_DIR = ''
if VIMCONFIG_DIR == ''
    let VIMCONFIG_DIR = $HOME."/.vim/conf"
endif

" exec ':so ' . VIMCONFIG_DIR . '/fuf.vim'
" exec ':so ' . VIMCONFIG_DIR . '/cscope_maps.vim'
colorscheme vividchalk
set t_Co=256
" cursor under line
set cursorline
hi CursorLine term=underline cterm=bold gui=bold
hi Search ctermfg=black ctermbg=yellow
