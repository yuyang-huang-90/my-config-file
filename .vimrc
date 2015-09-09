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
set tabstop=4
set softtabstop=4
set shiftwidth=4
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
set mouse=a
"noback
set nobackup
"number
set number
"ruler
set ru
"syntax
syntax on

"ctags
set tag=tags
set autochdir

"word warp
set tw=79

"fix the hotkey delay problem
set timeout timeoutlen=5000 ttimeoutlen=100

"adjust filetype recongnization
au BufRead {*.log,message} set ft=messages
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru} set ft=ruby
au BufRead,BufNewFile {*.md,*.mkd,*.markdown} set ft=markdown
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
"set foldmethosds
autocmd FileType javascript setl fdm=syntax
autocmd FileType c          setl fdm=syntax
autocmd FileType cpp        setl fdm=syntax
autocmd FileType objc       setl fdm=syntax
autocmd FileType java       setl fdm=syntax
autocmd FileType xml        setl fdm=syntax
" close syntex fold if file is too long
function! DisableSyntaxFoldForLongFile()
    if &l:foldmethod == 'syntax' && line('$') > 1000
        setl fdm=indent
    endif
endfunction
autocmd FileType * call DisableSyntaxFoldForLongFile()

"compile & run
autocmd FileType python map <buffer> <F5> <ESC>:!python3 %:p<CR>
autocmd FileType ruby   map <buffer> <F5> <ESC>:!ruby %:p<CR>
autocmd FileType cpp    map <buffer> <F5> <ESC>:make<CR>
autocmd FileType c      map <buffer> <F5> <ESC>:make<CR>
autocmd FileType java   map <buffer> <F5> <ESC>:make<CR>
autocmd Filetype cpp    map <buffer> <F4> <ESC>:!clang++ -g -Wall -std=c++11 % -o %:r<CR>
autocmd Filetype cpp    map <buffer> <F6> <ESC>:!./%:r<CR>
autocmd Filetype c      map <buffer> <F4> <ESC>:!clang -g -Wall -std=c++11 % -o %:r<CR>
autocmd Filetype c      map <buffer> <F6> <ESC>:!./%:r<CR>

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
" fast move
map <c-h> <c-w>h
map <c-k> <c-w>k
map <c-j> <c-w>j
map <c-l> <c-w>l
"latex suit
set grepprg=grep\ -nH\ $*
set shellslash
let g:tex_flavor='latex'
autocmd Filetype tex set iskeyword+=:
autocmd Filetype tex setlocal makeprg=make
let g:Tex_AutoFolding=0
"vundle
filetype off                   " required!
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
"
" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

" from github repo
Bundle 'tpope/vim-fugitive'
"easy motion
Bundle 'Lokaltog/vim-easymotion'
"emmet-vim is previous zendcoding.vim
"xml & html5
Bundle 'tpope/vim-surround'
Bundle 'xml.vim'
Bundle 'mattn/emmet-vim'
Bundle 'pangloss/vim-javascript'
Bundle 'othree/html5.vim'
autocmd Filetype xml,html,eruby imap <C-j> <C-y>j<C-y>j<C-y>n
" ycm and its support plugin
Bundle 'Valloric/YouCompleteMe'
"add dick complete
autocmd FileType javascript set dictionary+=$HOME/.vim/dict/node.dict
"nerd tree
Bundle 'scrooloose/nerdtree'
autocmd WinEnter * if exists("t:NERDTreeBufName") && winnr("$") == 1 &&bufwinnr(t:NERDTreeBufName) != -1 | q | endif
cmap NT<CR> NERDTree<CR>
cmap NTC<CR> NERDTreeClose<CR>
"minibufexpl
Bundle 'fholgado/minibufexpl.vim'
cmap MBF<CR> :MBEFocus<CR>
cmap MBC<CR> :MBEClose<CR>
"tagbar
Bundle 'majutsushi/tagbar'
cmap TB<CR> TagbarToggle<CR>
cmap TBC<CR> TagbarClose<CR>
"CCtree
Bundle 'hari-rangarajan/CCTree'
"fufinder
Bundle 'FuzzyFinder'
"fuf finder map
cmap ff<CR> FufFile<CR>
cmap fb<CR> FufBuffer<CR>
cmap fl<CR> FufLine<CR>
cmap fd<CR> FufDir<CR>

"eclim
"autocmd FileType ruby,java   let g:EclimCompletionMethod='omnifunc'
" vim-script
" l9 is a Vim-script library,provides some utility functions and commands
Bundle 'L9'

"octave
Bundle 'lsdr/octave.vim'
au BufRead,BufNewFile *.m,*.oct set ft=octave 
au BufRead,BufNewFile *.m,*.oct setl omnifunc=syntaxcomplete#Complete

Bundle 'ShowTrailingWhitespace'
" useful line up tools
Bundle 'Tabular'
Bundle 'jQuery'
Bundle 'nginx.vim'
Bundle 'Markdown'
Bundle 'haskell.vim'
" log viewer C-k to refresh
Bundle 'tailtab.vim'
"grep
Bundle 'grep.vim'
"vim-latex
Bundle 'sigefried/vim-latex'
"js & json
Bundle 'marijnh/tern_for_vim'
Bundle 'elzr/vim-json'
Bundle 'moll/vim-node'
"ruby & rails
Bundle 'vim-ruby/vim-ruby'
Bundle 'tpope/vim-rails.git'
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"vim template
Bundle 'aperezdc/vim-template'
"path utility
Bundle 'tpope/vim-pathogen'
"syntacstic config
Bundle 'scrooloose/syntastic'
" template config
let g:email                     = 'sigefriedhyy@gmail.com'
let g:username                  = 'sigefried'
"syntastic config
"call pathogen#infect()
let g:syntastic_python_checkers  = ['pylint']
let g:syntastic_ruby_checkers    = ['rubylint']
let g:syntastic_xml_checkers     = ['xmllint']
"let g:syntastic_xml_xmllint_args = '--dtdvalid tei_all.dtd'
"let g:syntastic_cpp_checkers   = []
"let g:syntastic_c_checkers     = []

let g:syntastic_error_symbol    = 'e'
let g:syntastic_warning_symbol  = 'w'
let g:syntastic_mode_map        = { 'mode': 'active'}
" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
"Bundle 'file:///Users/gmarik/path/to/plugin'

"ycm_extra_config_file

filetype plugin indent on     " required!
" some functions
" auto underline
function! s:Underline(chars)
  let chars = empty(a:chars) ? '-' : a:chars
  let nr_columns = virtcol('$') - 1
  let uline = repeat(chars, (nr_columns / len(chars)) + 1)
  put =strpart(uline, 0, nr_columns)
endfunction
command! -nargs=? Underline call s:Underline(<q-args>)

"function! s:FixQuote()
"    exec ":%s//'/g"
"endfunction
"command! FixQuote call s:FixQuote()

"format xml
function! s:XMLFormat()
    exe '%!xmllint --format --recover - 2>/dev/null'
endfunction
command! XMLFormat call s:XMLFormat()

"format html
function! s:HTMLFormat()
    exe '%!tidy -i -xml --show-errors 0 2>/dev/null'
endfunction
command! HTMLFormat call s:HTMLFormat()

"extraconfig
let VIMCONFIG_DIR = ''
if VIMCONFIG_DIR == ''
    let VIMCONFIG_DIR = $HOME."/.vim/conf"
endif

exec ':so ' . VIMCONFIG_DIR . '/fuf.vim'
exec ':so ' . VIMCONFIG_DIR . '/cscope_maps.vim'
"gui issue
if has('gui_running')
    if has('gui_macvim')
        set guifont=Menlo:h15
    else
        set guifont=Monospace\ 15
    endif
    colorscheme vividchalk
else
  "  colorscheme xterm16
    if has('mac')
        colorscheme vividchalk
    else
        colorscheme xterm16
    endif
endif


