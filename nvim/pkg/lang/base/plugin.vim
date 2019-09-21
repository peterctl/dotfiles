" Autocompletion framework
Plugin 'shougo/deoplete.nvim', {
        \ 'do': ':UpdateRemotePlugins',
        \ 'after': ['shougo/denite.nvim']
        \ }

" Language Server Protocol support.
Plugin 'autozimu/LanguageClient-neovim', {
        \ 'branch': 'next',
        \ 'do': 'bash install.sh'
        \ }

Plugin 'sheerun/vim-polyglot', { 'do': './build' } " Language support
