if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=ucs-bom,utf-8,latin1
endif

set nocompatible        " Use Vim defaults (much better!)
set bs=indent,eol,start " allow backspacing over everything in insert mode
set ai                  " always set autoindenting on
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class
"set backup             " keep a backup file
set viminfo='20,\"50    " read/write a .viminfo file, don't store more than 50 lines of registers
set history=50          " keep 50 lines of command line history
set ruler               " show the cursor position all the time
set number              " show the line numbers
set cursorline          " Highlight current line

" some speedup
set synmaxcol=128
set ttyfast " u got a fast terminal
set ttyscroll=3
set lazyredraw " to avoid scrolling problems

colorscheme wombat256mod

" Only do this part when compiled with support for autocommands
if has("autocmd")
  augroup redhat
  autocmd!
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
  " don't write swapfile on most commonly used directories for NFS mounts or USB sticks
  autocmd BufNewFile,BufReadPre /media/*,/mnt/* set directory=~/tmp,/var/tmp,/tmp
  " start with spec file template
  autocmd BufNewFile *.spec 0r /usr/share/vim/vimfiles/template.spec
  augroup END
endif

if has("cscope") && filereadable("/usr/bin/cscope")
   set csprg=/usr/bin/cscope
   set csto=0
   set cst
   set nocsverb
   " add any database in current directory
   if filereadable("cscope.out")
      cs add cscope.out
   " else add database pointed to by environment
   elseif $CSCOPE_DB != ""
      cs add $CSCOPE_DB
   endif
   set csverb
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

filetype on
filetype plugin on

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif

" Don't wake up system with blinking cursor:
" http://www.linuxpowertop.org/known.php
let &guicursor = &guicursor . ",a:blinkon0"

" folding
" set foldenable
set nofoldenable
set foldmethod=indent

" Tlist
"let Tlist_Use_Right_Window = 1
"nnoremap <silent> <F8> :TlistToggle<CR>

" NerdTree
map <F2> :NERDTreeToggle<CR>
let g:NERDTreeDirArrows=0
let NERDTreeIgnore=['\.pyc$']

"if has("mouse")
    "set mouse=a
"endif

" Tagbar
nnoremap <F8> :TagbarToggle<CR>
" let g:tagbar_foldlevel = 0 "close tagbar folds by defaul
let g:tagbar_width=26
let g:tagbar_sort = 0 "tagbar shows tags in order of they created in file

"Tabs settings for Python
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab "Ставим табы пробелами
set softtabstop=4 "4 пробела в табе
set autoindent
let python_highlight_all = 1

"Turn 256 colours on for terminal
set t_Co=256

"highlight too long lines
set colorcolumn=80
hi ColorColumn ctermbg=8
""highlight OverLength ctermbg=red ctermfg=white guibg=#592929
""match OverLength /\%81v.\+/
""if exists('+colorcolumn')
""  set colorcolumn=80
""else
""  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
""endif

"Strip EOL whitespaces in .py files
autocmd BufWritePre *.py normal m`:%s/\s\+$//e ``
"Smart indents in .py files
autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

"Tune omnicomletion for Python (and for js, html, css)
set omnifunc=syntaxcomplete#Complete
"autocmd FileType python set omnifunc=pythoncomplete#Complete
"autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
"autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
"autocmd FileType css set omnifunc=csscomplete#CompleteCSS
" " autocmd FileType python setlocal omnifunc=RopeCompleteFunc

"Switch off .swp and ~ (backup) files
set nobackup
set noswapfile

"My abbrs
abbr loginfo logging.info('%s' % ())
abbr logdebug logging.debug('%s' % ())
abbr logerror logging.error('%s' % ())

" "Pathogen
execute pathogen#infect()
call pathogen#helptags() " generate helptags for everything in 'runtimepath'

"jedi-vim related tuning
"let g:pymode_rope = 0

"pymode settings
" Don't autofold code
let g:pymode_folding = 0
" syntax highlighting
let g:pymode_syntax = 1
let g:pymode_syntax_all = 1
let g:pymode_syntax_indent_errors = g:pymode_syntax_all
let g:pymode_syntax_space_errors = g:pymode_syntax_all
let g:pymode_syntax_highlight_self = g:pymode_syntax_all
" rope autocomplete
let g:pymode_rope = 1
let g:pymode_rope_complete_on_dot = 0
let g:pymode_rope_autoimport = 1
let g:pymode_rope_autoimport_modules = ['os', 'sys', 'shutil', 'datetime', 'logging']
let ropevim_vim_completion=1
let ropevim_extended_complete=1
" common
let g:pymode_trim_whitespaces = 1   " Trim unused white spaces on save
" " let g:pymode_options_max_line_length = 119
" let g:pymode_options_max_line_length = 79
" let g:pymode_options_colorcolumn = 1
" hi ColorColumn ctermbg=8
" indents
let g:pymode_indent = 1
" code checking
let g:pymode_lint_on_write = 0  " Don't check code on every save (if file has been modified)
let g:pymode_lint_sort = ['E', 'C', 'I']

" nerd commenter
" let g:NERDCustomDelimiters = { 'py' : { 'left': '# ', 'leftAlt': '', 'rightAlt': '' }}
let g:NERDSpaceDelims = 1   " leave a space between commentstring and the code

" auto ctags
" let g:auto_ctags = 1
" let g:auto_ctags_tags_args = '--tag-relative --recurse --sort=yes'
" let g:auto_ctags_directory_list = ['.git', '.svn']

" fonts
" set guifont=Liberation\ Mono\ for\ Powerline\ 10

" airline
set laststatus=2
" let g:airline_powerline_fonts = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" unicode symbols
let g:airline_left_sep = '»'
let g:airline_left_sep = '>'
let g:airline_right_sep = '«'
let g:airline_right_sep = '<'
let g:airline_symbols.linenr = 'LF'
let g:airline_symbols.linenr = 'NL'
let g:airline_symbols.linenr = '¶'
let g:airline_symbols.branch = '⎇'
let g:airline_symbols.paste = 'ρ'
let g:airline_symbols.paste = 'Þ'
let g:airline_symbols.paste = '∥'
let g:airline_symbols.whitespace = 'Ξ'

" indentLine
let g:indentLine_char = '|'
let g:indentLine_color_term = 236

" spacehi.vim
" autocmd syntax * SpaceHi  " syntax only
autocmd BufNewFile,BufReadPost,FilterReadPost,FileReadPost,Syntax * SpaceHi
let g:spacehi_tabcolor="ctermfg=White ctermbg=Red guifg=White guibg=Red"
let g:spacehi_spacecolor="ctermfg=Black ctermbg=Yellow guifg=Blue guibg=Yellow"
let g:spacehi_nbspcolor="ctermfg=White ctermbg=Red guifg=White guibg=Red"
" enable visible whitespace (spacehi.vim alternative)
" set listchars=tab:»·,trail:·,precedes:<,extends:>
" set list
