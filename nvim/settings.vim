" This file is loaded before anything else. Its purpose is to define the way
" that plugins and configuration should be loaded. Anything else, like actual
" configuration or function definition, should be placed inside the config
" directory. Also, any possible configurations should also be set inside the
" config directory, and if they should be configurable from a setting in this
" file, that should be a global variable that defines the way the actual
" configuration is set.

" Override the background color settigs in the colorscheme and make the
" background transparent.
let g:transparent_bg = 0

" Enable relative line numbering at startup.
let g:relative_line_numbers = 1

" Disable navigation using arrow keys.
let g:no_noob_mode = 0

" Enable the autocompletion system at startup.
let g:deoplete#enable_at_startup = 1

let g:airline_powerline_fonts = 1

let g:indentLine_showFirstIndentLevel = 1
