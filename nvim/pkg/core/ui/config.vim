" UI configuration.

" Set colorscheme.
exec 'colorscheme' g:colorscheme

" Highlight current line.
set cursorline

" Transparent background.
if IsFlagSet('g:transparent_background')
    set nocursorline
    hi Normal guibg=NONE ctermbg=NONE
endif

if ! IsFlagSet('g:disable_special_characters')
    let g:airline_powerline_fonts = 1
endif

" Show indentation ruler at first indentation level.
let g:indentLine_showFirstIndentLevel = 1

" Show matching brackets and parentheses.
set showmatch

" Highlight search results.
set hlsearch

" Show completion list on command window.
set wildmenu

" Minimum lines to keep above and below cursor.
set scrolloff=3

" Minimum lines to keep before and after cursor.
set sidescrolloff=5

" Automatically fold code.
set foldenable

" Show whitespace.
set list
" set listchars=tab:→\ ,trail:•,extends:>,precedes:<,nbsp:+
set listchars=tab:›\ ,eol:¬,trail:⋅,nbsp:•,extends:>,precedes:<
set showbreak=↪

" Enable split down and vsplit right.
set splitright
set splitbelow

" Don't show the current mode below the status line.
set noshowmode

" Show the ruler.
set ruler

" Format the ruler similar to vim-airline.
set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%)

" Show partial commands in the status line and selected characters
" in visual mode
set showcmd

" File explorer settings.
let g:netrw_liststyle = 3 " Use tree view
let g:netrw_sort_sequence = '[\/]$,*' " Sort directories first and then files
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = -32

" TODO source line-numbers and airline
exec 'source ' . expand('<sfile>:p:h') . '/airline.vim'
exec 'source ' . expand('<sfile>:p:h') . '/line-numbers.vim'
