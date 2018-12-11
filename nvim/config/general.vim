" General configuration.

" Enable mouse support for all modes.
set mouse=a

" Wrap left and right navigation at end and beginning of lines.
set whichwrap=b,s,h,l,<,>,[,]

" Make backspace work like you'd expect in any other editor.
set backspace=indent,eol,start

" Search as you type.
set incsearch

" Case insensitive search.
set ignorecase

" Case sensitive search when uc is present.
set smartcase

" Use system clipboard for copy / paste.
set clipboard+=unnamedplus

" Enable many unsaved buffers.
set hidden

" Gutentag tags output folder.
let g:gutentags_cache_dir = '~/.cache/nvim/gutentags'

let g:deoplete#enable_at_startup = 1

