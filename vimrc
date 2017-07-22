set spell spelllang=en_gb

" keep 3 lines on the bottom and top when scrolling
set so=3

" highlight cursor line and column
set cursorline
set cursorcolumn

" line numbers
set number
set relativenumber

" autocomplete menu in cmd
set wildmenu

" turn off annoying stuff
set noswapfile
set nowritebackup
set nocompatible

" highlight 80 column
set colorcolumn=80

" allow switching to other buffer without saving the current one
set hidden

" autocomplete by tab
imap <Tab> <C-n>

imap jj <ESC>:w<CR>
imap jk <ESC>:w<CR>
imap kk <ESC>:w<CR>
nmap j gj
nmap k gk

" delay before execution
set tm=400

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50        " keep 50 lines of command line history
set ruler             " show the cursor position all the time
set showcmd           " display incomplete commands
set incsearch         " do incremental searching

cmap E<CR> Ex<CR>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
  map <ScrollWheelUp> <C-Y>
  map <ScrollWheelDown> <C-E>
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
              \ | wincmd p | diffthis
endif

func GitGrep(...)
  let save = &grepprg
  set grepprg=git\ grep\ -n\ $*
  let s = 'grep'
  for i in a:000
    let s = s . ' ' . i
  endfor
  exe s
  let &grepprg = save
endfun
command -nargs=? G call GitGrep(<f-args>)

func GitGrepWord()
  normal! "zyiw
  call GitGrep('-w -e ', getreg('z'))
endf
nmap K :call GitGrepWord()<CR>:copen<CR>

" set statusline=%{fugitive#statusline()}
" set statusline+=%t      "tail of the filename
" set statusline+=[%{strlen(&fenc)?&fenc:'none'}, "file encoding
" set statusline+=%{&ff}] "file format
" set statusline+=%h      "help file flag
" set statusline+=%m      "modified flag
" set statusline+=%r      "read only flag
" set statusline+=%y      "filetype
" set statusline+=%=      "left/right separator
" set statusline+=%c,     "cursor column
" set statusline+=%l/%L   "cursor line/total lines
" set statusline+=\ %P    "percent through file
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

""" FILETYPES

filetype off
filetype plugin indent on

if has("autocmd")
  " Enable file type detection
  filetype on

  autocmd BufNewFile,BufRead *.ejs set filetype=html
  autocmd BufNewFile,BufRead *.vue set filetype=html
  autocmd BufNewFile,BufRead Jakefile set filetype=javascript
  autocmd FileType yaml       setlocal ts=2 sts=2 sw=2 et
  autocmd FileType jade       setlocal ts=2 sts=2 sw=2 et
  autocmd FileType ejs        setlocal ts=4 sts=4 sw=4 et
  autocmd FileType elm        setlocal ts=4 sts=4 sw=4 et
  autocmd FileType ruby       setlocal ts=2 sts=2 sw=2 et
  autocmd FileType cucumber   setlocal ts=2 sts=2 sw=2 noet nolist
  autocmd FileType make       setlocal ts=4 sts=4 sw=4 noet
  autocmd FileType javascript setlocal ts=4 sts=4 sw=4 et
  autocmd FileType json       setlocal ts=4 sts=4 sw=4 et
  autocmd FileType vue        setlocal ts=4 sts=4 sw=4 et
  autocmd FileType coffee     setlocal ts=4 sts=4 sw=4 et
  autocmd FileType html       setlocal ts=4 sts=4 sw=4 et
  autocmd FileType css        setlocal ts=2 sts=2 sw=2 et


   " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

endif


""" PLUGINS

call plug#begin()

Plug 'Valloric/YouCompleteMe'

" The Gruvbox suite of color schemes is developed with an extreme level of
" thought and care.
Plug 'morhetz/gruvbox'


" Airline is a "lean & mean status/tabline for Vim that's light as air."
Plug 'vim-airline/vim-airline'


" Syntastic is a syntax checking plugin
Plug 'scrooloose/syntastic'


" Elm plugin for vim
Plug 'elmcast/elm-vim'


" Surround
Plug 'tpope/vim-surround'


" Startify
Plug 'mhinz/vim-startify'

let g:startify_custom_header_quotes = [
    \ ["Everybody has a plan until they get punched in the mouth. - Mike Tyson" ],
    \ ["Perfectionism is a failure to optimize across a complex goal space,", "settling, instead, on ignoring the difficult prioritisation problem", "in favor of over-optimizing a limited set of tangible and easily-defined goals over longer-run priorities" ],
    \ ["Look, I made a hat...where there never was a hat. - Finishing the hat, Sondheim" ],
    \ ["Just fucking figure it out." ],
    \ ["The universe is not here to please you. - Charles Murtaugh" ],
    \ ["Your life is your life. The gods await to delight in you. - Bukowski" ],
    \ ["Join the force and get a pension. - Salesman" ],
    \ ["Beware of things that are fun to argue. - Eliezer Yudkowsky" ],
    \ ["However beautiful the strategy, you should occasionally look at the result. - Winston Churchill" ],
    \ ["Truth is much too complicated to allow anything but approximations. - John Von Neumann" ],
    \ ["Writing program code is a good way of debugging your thinking. - Bill Venables" ],
    \ ["Most haystacks do not even have a needle. - Lorenzo" ],
    \ ["Experiment and theory often show remarkable agreement when performed in the same laboratory. - Daniel Bershader" ],
    \ ["The important work of moving the world forward does not wait to be done by perfect men. - George Eliot" ],
    \ ["It is astonishing what foolish things a man thinking alone can come temporarily to believe. - Keynes" ],
    \ ["The purpose of computing is Insight, not numbers. - Richard Hamming" ],
    \ ["Sometimes magic is just someone spending more time on something than anyone else might reasonably expect. - Teller" ],
    \ ["Don't tell me what you value. Show me your budget, and I\'ll tell you what you value. - Joe Biden quoting his father" ],
    \ ["Work on stuff that matters. - Tim O\'Reilly" ],
    \ ["You have to say something. It can\'t all be technique. - Woody Allen (on great actors)" ]
    \ ]


call plug#end()

" you complete me
let g:ycm_semantic_triggers = {
     \ 'elm' : ['.'],
     \}

" gruvbox
set background=dark
colorscheme gruvbox

" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#syntastic#enabled=0

" elm-vim
let g:elm_detailed_complete = 1
" let g:elm_format_autosave = 1
let g:elm_syntastic_show_warnings = 1
let g:elm_setup_keybindings = 1

" syntastic
let g:syntastic_elm_checkers = [ 'elm_make' ]
let g:syntastic_javascript_checkers=['eslint']
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
set laststatus=2

