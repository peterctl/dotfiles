" Do not run in Vi compatibility mode.
set nocompatible

" Set the NeoVim config directory root as a global variable.
let g:nvimroot = expand('<sfile>:p:h')

" Set the plugin installation directory as a global variable.
let g:pluginroot = '~/.local/share/nvim/plugins'

" Add the current directory to (Neo)Vim's runtime path in case this file is
" being sourced from the (Neo)Vim rc.
exec 'set runtimepath+=' . g:nvimroot

" Load config framework libs.
exec 'source ' . g:nvimroot . '/lib/pkg.vim'
exec 'source ' . g:nvimroot . '/lib/plug-dependencies.vim'
exec 'source ' . g:nvimroot . '/lib/helpers.vim'
exec 'source ' . g:nvimroot . '/defaults.vim'

" Initialize the package framework.
call InitPackageFramework(g:nvimroot)

" Wrap the rest of the config initialization in a function to be called later.
function InitVimConfig()
    call ResolvePackageList()

    " Load wrapped plugin definitions from packages.
    call LoadSectionFromAllPackages('plugin')

    " Begin plugin definitions.
    call plug#begin(g:pluginroot)

    " Make Vim compatible with NeoVim plugins.
    if !has('nvim')
        Plug 'roxma/nvim-yarp' " Remote plugin framework.
        Plug 'roxma/vim-hug-neovim-rpc' " NeoVim RPC compatibility for Vim.

        function s:nop()
            " Function that does nothing. Similar to the <Nop>
            " keymap.
        endfunction

        " Define the UpdateRemotePlugins command in vim so that we don't need to
        " handle special cases in plugin definitions in vim.
        command! -nargs=* UpdateRemotePlugins :call s:nop()
    endif

    " Translate wrapped Plugin calls into Plug calls.
    call LoadPlugins()

    " Initialize plugins.
    call plug#end()

    " Load configs and keymaps.
    call LoadSectionFromAllPackages('config')
    call LoadSectionFromAllPackages('keymap')
endfunction
