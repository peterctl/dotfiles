" UI configuration.

" Set colorscheme.
colorscheme onedark

" Highlight current line.
set cursorline

" Transparent background.
if IsFlagSet('g:transparent_bg')
	set nocursorline
	hi Normal guibg=NONE ctermbg=NONE
endif

" Enable line numbers.
set number
if IsFlagSet('g:relative_line_numbers')
	set relativenumber
	augroup numbertoggle
		autocmd!
		autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
		autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
	augroup END
else
	set norelativenumber
endif


" Show matching brackets and parentheses.
set showmatch

" Highlight search results.
set hlsearch

" Show completion list on command window.
set wildmenu

" Minimum lines to keep above and below cursor.
set scrolloff=3

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

