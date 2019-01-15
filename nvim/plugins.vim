" Plugin definitions.

" Color schemes
Plug 'joshdick/onedark.vim'
Plug 'rakr/vim-one'
Plug 'nightsense/carbonized' " For limited 16 color terminals

" General plugins.
Plug 'vim-airline/vim-airline' " Statusline
Plug 'scrooloose/nerdtree' " File tree sidebar
Plug 'jistr/vim-nerdtree-tabs' " Better tab management for NERDTree
Plug 'xuyuanp/nerdtree-git-plugin' " Git support for NERDTree
Plug 'mbbill/undotree' " Persitent file change tree
Plug 'ctrlpvim/ctrlp.vim' " Fuzzy file search
Plug 'tacahiroy/ctrlp-funky' " Find tags and symbols from CtrpP
Plug 'terryma/vim-multiple-cursors' " Multiple cursors
Plug 'vim-scripts/sessionman.vim' " Saveable sessions
Plug 'easymotion/vim-easymotion' " Easier file navigation
Plug 'nathanaelkane/vim-indent-guides' " Indent guidelines
Plug 'Yggdroot/indentLine' " Show indent guidelines
Plug 'vim-scripts/restore_view.vim' " Restore file cursor positions
Plug 'mhinz/vim-signify' " Show git diffs in the sign column
Plug 'tpope/vim-abolish' " Better search and substitute
Plug 'osyo-manga/vim-over' " Substitute previews
Plug 'gcmt/wildfire.vim' " Smart selection of surrounding objects
Plug 'tpope/vim-vinegar' " Extensions to the netrw file explorer

"Plug 'shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' } " File explorer
Plug 'shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' } " User interface framework
Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' } " Autocompletion framework
Plug 'wokalski/autocomplete-flow'
Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

" General programming related plugins.
Plug 'w0rp/ale' " Async file syntax linting
Plug 'ludovicchabant/vim-gutentags' " Tag file management
Plug 'editorconfig/editorconfig-vim' " Respects settings from .editorconfig
Plug 'tpope/vim-fugitive' " Git wrapper
Plug 'tomtom/tcomment_vim' " Motion driven comments
Plug 'tpope/vim-surround' " Surround text with braces / parentheses / quotes
Plug 'godlygeek/tabular' " Text filtering and alignment
Plug 'luochen1990/rainbow' " Rainbow parentheses and brackets
Plug 'majutsushi/tagbar' " Show tags in a window
Plug 'jiangmiao/auto-pairs' " Automatically close and format brace,
                            " parenthesis and quote pairs.
Plug 'tpope/vim-endwise' " Automatically close code blocks.

" Git related stuff.
Plug 'sodapopcan/vim-twiggy' " Sidebar to show branches.
Plug 'christoomey/vim-conflicted' " Manage conflicts more easily.

" Language Server Protocol support.
Plug 'autozimu/LanguageClient-neovim', {
            \ 'branch': 'next',
            \ 'do': 'bash install.sh'
            \ }

" Golang related plugins.
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'zchee/deoplete-go', { 'do': 'make' }

" vim-polyglot has to go after vim-go
" https://github.com/fatih/vim-go/issues/2045
Plug 'sheerun/vim-polyglot', { 'do': './build' } " Language support

" C/C++ related plugins.
Plug 'zchee/deoplete-clang'

" Javascript/Typescript related plugins.
Plug 'HerringtonDarkholme/yats.vim'
Plug 'mhartington/nvim-typescript', { 'do': './install.sh' }
Plug 'wokalski/autocomplete-flow'

" PHP related plugins.
Plug 'lvht/phpcd.vim', { 'for': 'php', 'do': 'composer install' }

" Tmuxline or something
Plug 'edkolev/tmuxline.vim'
