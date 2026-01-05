"====== BASIC CONFIG========
" allow backspacing over everything in insert mode
set backspace=indent,eol,start

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
" Automatically refresh the contents if file changed
set autoread
" Enable mouse usage (all modes)
set mouse=a
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
set wrap
set tw=79

" update time
set updatetime=300

"fix the hotkey delay problem
set timeout timeoutlen=500 ttimeoutlen=100

" UI enhancements
set scrolloff=8
set signcolumn=yes
set list

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

"====== KEYBINDINGS========
" Match init.lua keybindings
nmap Q gq
nmap <Space> za
nmap mp :bp<CR>
nmap mn :bn<CR>

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

" turn on indentation
filetype plugin indent on
"syntax
syntax on

"====== EXTRA CONFIG========
set clipboard=unnamedplus

" Enable 24-bit RGB colors
set termguicolors

colorscheme default
set t_Co=256
" cursor under line
set cursorline
hi CursorLine term=underline cterm=bold gui=bold
hi Search ctermfg=black ctermbg=yellow

" Make autoread more reliable by checking for file changes on various events
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FileChangedShellPost * echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None
