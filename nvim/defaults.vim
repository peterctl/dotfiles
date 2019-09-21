" This file is loaded before anything else in the dotfiles. Its purpose is
" to define the default way that plugins and configuration should be loaded.
" To override any variable in this file simply set that variable in the rc
" file before sourcing init.vim from the dotfiles. As such, only variable
" definitions should go here. Any possible configurations should also be set
" inside the config/ directory, and if they should be configurable from a
" variable in this file, then that variable should have a global scope.

" Dynamically set the colorscheme.
if !exists('g:colorscheme')
    let g:colorscheme = 'onedark'
endif

" Override the background color settigs in the colorscheme and make the
" background transparent.
if !exists('g:transparent_background')
    let g:transparent_background = 1
endif

" Enable relative line numbering at startup.
if !exists('g:relative_line_numbers')
    let g:relative_line_numbers = 1
endif

" Disable navigation using arrow keys.
if !exists('g:disable_noob_mode')
    let g:disable_noob_mode = 0
endif

" Disable special characters like powerline icons.
if !exists('g:disable_special_characters')
    let g:disable_special_characters = 0
endif

