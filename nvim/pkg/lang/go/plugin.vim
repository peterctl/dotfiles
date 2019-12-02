" vim-go has to go before vim-polyglot
" https://github.com/fatih/vim-go/issues/2045
Plugin 'fatih/vim-go', { 'do': ':GoUpdateBinaries', 'before': ['sheerun/vim-polyglot'] }
" Plugin 'zchee/deoplete-go', { 'do': 'make', 'after': ['shougo/deoplete.nvim'] }

