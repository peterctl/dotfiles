" NeoVim configuration by PeterCP.
"
" This file loads the config with all the default settings. To customize the
" configuration, source lib.vim instead, then modify any configurations and
" call InitVimConfig().

" Set the NeoVim config directory root as a global variable.
let g:nvimroot = expand('<sfile>:p:h')

exec 'source ' . g:nvimroot . '/lib.vim'

call InitVimConfig()
