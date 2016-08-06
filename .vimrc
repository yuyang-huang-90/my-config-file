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
set mouse=a
"noback
set nobackup
"number
set number
"ruler
set ru
"syntax
syntax on

"ctags set tag=tags set autochdir

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

"======END OF BASIC CONFIG========



"====== VIM PLUGINS========
" requried for vundle but no need for vim-plugin
"filetype off
call plug#begin('~/.vim/plugged')

"** EDITOR EXTENTION PLUGIN
Plug 'Lokaltog/vim-easymotion'
Plug 'tpope/vim-surround'
" nerd tree
Plug 'scrooloose/nerdtree'
"BufExplForceSyntaxEnable = 1
"minibufexpl
Plug 'fholgado/minibufexpl.vim'
"tagbar
Plug 'majutsushi/tagbar'
"CCtree
Plug 'hari-rangarajan/CCTree'
" l9 is a Vim-script library,provides some utility functions and commands
Plug 'L9'
"fufinder
Plug 'FuzzyFinder'
Plug 'ShowTrailingWhitespace'
" useful line up tools
Plug 'Tabular'
Plug 'Yggdroot/indentLine'
" log viewer C-k to refresh
Plug 'tailtab.vim'
"grep
Plug 'grep.vim'
"path utility
Plug 'tpope/vim-pathogen'

" nerd tree setting and key bind
autocmd WinEnter * if exists("t:NERDTreeBufName") && winnr("$") == 1 &&bufwinnr(t:NERDTreeBufName) != -1 | q | endif
cmap NT<CR> NERDTree<CR>
cmap NTC<CR> NERDTreeClose<CR>
" minibuf setting and key bind
let g:miniBufExplForceSyntaxEnable = 1
cmap MBF<CR> :MBEFocus<CR>
cmap MBC<CR> :MBEClose<CR>
" tagbar setting and key bind
cmap TB<CR> TagbarToggle<CR>
cmap TBC<CR> TagbarClose<CR>
" fuf setting and key bind
cmap ff<CR> FufFile<CR>
cmap fb<CR> FufBuffer<CR>
cmap fl<CR> FufLine<CR>
cmap fd<CR> FufDir<CR>
" indentLine setting and key bind
let g:indentLine_leadingSpaceEnabled = 1


"** VERSION CONTROL PLUGIN
" git warpper
Plug 'tpope/vim-fugitive'


"** WEB DEV PLUGIN
" Plug 'marijnh/tern_for_vim'
" Plug 'elzr/vim-json'
" Plug 'moll/vim-node'
" Plug 'jQuery'
" Plug 'xml.vim'
" Plug 'mattn/emmet-vim'
" Plug 'pangloss/vim-javascript'
" Plug 'othree/html5.vim'
" emmet setting keybind
" autocmd Filetype xml,html,eruby imap <C-j> <C-y>j<C-y>j<C-y>n


"** RUBY & RAILS
Plug 'vim-ruby/vim-ruby'
" Plug 'tpope/vim-rails'


"** ADDITIONAL SYMTAX
"octave
Plug 'lsdr/octave.vim'
Plug 'nginx.vim'
Plug 'Markdown'
Plug 'haskell.vim'
" octave setting and config
au BufRead,BufNewFile *.m,*.oct set ft=octave 
au BufRead,BufNewFile *.m,*.oct setl omnifunc=syntaxcomplete#Complete


"** YCM AND ITS SUPPORT PLUGIN
Plug 'Valloric/YouCompleteMe'
"add dick complete
autocmd FileType javascript set dictionary+=$HOME/.vim/dict/node.dict
autocmd FileType ruby,eruby set omnifunc=rubycomplete#Complete
autocmd FileType ruby,eruby let g:rubycomplete_buffer_loading = 1
autocmd FileType ruby,eruby let g:rubycomplete_rails = 1
autocmd FileType ruby,eruby let g:rubycomplete_classes_in_global = 1
"eclim
"autocmd FileType ruby,java   let g:EclimCompletionMethod='omnifunc'


" ** SYNTAX CHECK 
"syntacstic config
Plug 'scrooloose/syntastic'
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


"** LATEX SUIT
Plug 'sigefried/vim-latex'
"latex suit setting and keymap
set grepprg=grep\ -nH\ $*
set shellslash
let g:tex_flavor='latex'
autocmd Filetype tex set iskeyword+=:
autocmd Filetype tex setlocal makeprg=make
let g:Tex_AutoFolding=0


"** VIM TEMPLATE
Plug 'aperezdc/vim-template'
" template config
let g:email                     = 'Yuyang@jp.sony.com'
let g:username                  = 'yuyang'


"** DEBUGGER SUPPORT
" for gdb and lldb support
" Plug 'gilligan/vim-lldb'
"Plug 'critiqjo/lldb.nvim'
" pyclewn
" Conque GDB
"Plug 'vim-scripts/Conque-GDB'
"

" ** GOOGLE CODE FMT SUPPORT
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plug 'google/vim-maktaba'
Plug 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plug 'google/vim-glaive'

" **GOLANG
Plug 'fatih/vim-go'

" **VIM WIKI
Plug 'vimwiki/vimwiki'

" All of your Plugs must be added before the following line
call plug#end()

" the glaive#Install() should go after the 'call vundle#end()'
call glaive#Install()

" turn on indentation
filetype plugin indent on

"====== END OF VIM PLUGIN========


"====== USERDEF FUNCTIONS========
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

" close syntex fold if file is too long
function! DisableSyntaxFoldForLongFile()
    if &l:foldmethod == 'syntax' && line('$') > 1000
        setl fdm=indent
    endif
endfunction
"====== END OF USERDEF FUNCTION========


"====== EXTRA CONFIG========
let VIMCONFIG_DIR = ''
if VIMCONFIG_DIR == ''
    let VIMCONFIG_DIR = $HOME."/.vim/conf"
endif

exec ':so ' . VIMCONFIG_DIR . '/fuf.vim'
exec ':so ' . VIMCONFIG_DIR . '/cscope_maps.vim'
"gui issue
"if has('gui_running')
"    if has('gui_macvim')
"        set guifont=Menlo:h15
"    else
"        set guifont=Monospace\ 15
"    endif
"    colorscheme vividchalk
"else
"  "  colorscheme xterm16
"    if has('mac')
"        colorscheme vividchalk
"    else
"        colorscheme xterm16
"    endif
"endif

" force to use vividchalk 
colorscheme vividchalk
set t_Co=256

" cursor under line
set cursorline
"hi CursorLine term=underline cterm=bold gui=bold
hi Search ctermfg=black ctermbg=yellow



