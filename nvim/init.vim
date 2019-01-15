" NeoVim configuration by PeterCP.

" The configuration directory is structured as follows:
" - plugins.vim: All plugin definitions (e.g. Plug '<plugin>') go here.
" - settings.vim: All settings go here. They are loaded before anything else
"   and should only be used to configure the way everything else is loaded
"   and/or configured.
" - helpers.vim: All helper functions go here.

" Do not run in Vi compatibility mode.
set nocompatible

" Set the NeoVim config directory root as a global variable.
let g:nvimroot = expand('<sfile>:p:h')

" Set the plugin installation directory as a global variable.
let g:pluginroot = '~/.local/share/nvim/plugins'

" Add the current directory to (Neo)Vim's runtime path in case this file is
" being sourced from the (Neo)Vim rc.
exec 'set runtimepath+=' . g:nvimroot

" Load helpers and settings.
exec 'source ' . g:nvimroot . '/helpers.vim'
exec 'source ' . g:nvimroot . '/settings.vim'

" Begin plugin defintions.
call plug#begin(g:pluginroot)

" Make Vim compatible with NeoVim plugins.
if !has('nvim')
    Plug 'roxma/nvim-yarp' " Remote plugin framework
    Plug 'roxma/vim-hug-neovim-rpc' " NeoVim RPC compatibility for Vim

    function s:nop()
        " This function does nothing. It is equivalent to the <Nop> key map.
    endfunction
    " Define the UpdateRemotePlugins command in vim so that we don't need to
    " handle special cases in plugin definitions in vim.
    command! -nargs=* UpdateRemotePlugins :call s:nop()
endif

" Source plugin definitions.
exec 'source ' . g:nvimroot . '/plugins.vim'

" Initialize plugins.
call plug#end()

" Recursively source all .vim files inside the config directory.
call RecursiveSource(g:nvimroot . '/config')

