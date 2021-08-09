set nocompatible        " Use Vim defaults (much better!)
set bs=indent,eol,start " allow backspacing over everything in insert mode
set ai                  " always set autoindenting on
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set number              " show the line numbers
set cursorline          " Highlight current line

set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set softtabstop=4
set autoindent
let python_highlight_all = 1
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

set t_Co=256

set colorcolumn=119

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
    syntax on
    set hlsearch
endif

" folding
" set foldenable
set nofoldenable
set foldmethod=indent

filetype on
filetype plugin on

" Switch off .swp and ~ (backup) files
set nobackup
set noswapfile

" some speedup
set synmaxcol=128
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

colorscheme wombat256mod
" ruler color
hi ColorColumn ctermbg=8

" auto shebang
augroup Shebang
    autocmd BufNewFile *.py 0put =\"#!/usr/bin/env python\<nl>\"|$
augroup END

" don't replace tabs and spaces with special charactres
" set listchars=tab:»·,trail:·,precedes:<,extends:>

" When editing a file, always jump to the last cursor position
augroup lastCurPos
    autocmd!
    autocmd BufReadPost *
    \ if line("'\"") > 0 && line ("'\"") <= line("$") |
    \   exe "normal! g'\"" |
    \ endif
augroup END

set splitright


"""""""""""""""
""" Mappings"""
"""""""""""""""

" buffers navigation
map gB :bprevious<CR>
map gb :bnext<CR>


"""""""""""""""
""" Plugins """
"""""""""""""""

""" vim plug """
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

Plug 'preservim/nerdcommenter'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

Plug 'tpope/vim-fugitive'

Plug 'haya14busa/incsearch.vim'

Plug 'vim-scripts/delimitMate.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

Plug 'python-mode/python-mode', { 'for': 'python', 'branch': 'develop' }

Plug 'ycm-core/YouCompleteMe'

Plug 'Glench/Vim-Jinja2-Syntax'

Plug 'preservim/tagbar'

Plug 'psf/black', { 'branch': 'stable' }

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

call plug#end()




"pymode settings
" Don't autofold code
let g:pymode_folding = 0
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
" common
let g:pymode_trim_whitespaces = 1   " Trim unused white spaces on save
" indents
let g:pymode_indent = 1
" code checking
let g:pymode_lint = 1
let g:pymode_lint_checkers = ['pyflakes', 'pep8', 'mccabe']
" let g:pymode_lint_on_write = 1  " Don't check code on every save (if file has been modified)
let g:pymode_lint_sort = ['E', 'C', 'I']
" ignore some pep8 warnings
let g:pymode_lint_ignore="E116,W503"

" NerdTree
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
let NERDTreeIgnore=['\.pyc$']

" NerdCommenter
" leave a space between commentstring and the code
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
" let g:NERDDefaultAlign = 'left'

" airline
set laststatus=2
let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
" " let g:airline_left_sep = '»'
" " let g:airline_left_sep = '>'
" let g:airline_left_sep = '▶'
" " let g:airline_right_sep = '«'
" " let g:airline_right_sep = '<'
" let g:airline_right_sep = '◀'
" " let g:airline_symbols.linenr = 'LF'
" " let g:airline_symbols.linenr = 'NL'
" let g:airline_symbols.linenr = '¶'
" let g:airline_symbols.branch = '⎇'
" let g:airline_symbols.paste = 'ρ'
" " let g:airline_symbols.paste = 'Þ'
" " let g:airline_symbols.paste = '∥'
" let g:airline_symbols.whitespace = 'Ξ'

" incsearch
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
map g/ <Plug>(incsearch-stay)

" fzf key bindings
nnoremap <C-f> :FZF<CR>
nnoremap <C-b> :Buffers<CR>
nnoremap <C-g> :Ag<CR>

" tagbar
nnoremap <F8> :TagbarToggle<CR>
" let g:tagbar_foldlevel = 0 "close tagbar folds by default
let g:tagbar_width=26
let g:tagbar_sort = 0 "tagbar shows tags in order of they created in file"
