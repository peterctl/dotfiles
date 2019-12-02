" Make navigation work on wrapped lines.
noremap <buffer> <silent> k gk
noremap <buffer> <silent> j gj
" noremap <buffer> <silent> 0 g0
" noremap <buffer> <silent> $ g$

" Disallow navigation using arrow keys.
if IsFlagSet("g:disable_noob_mode")
    map <Left> <Nop>
    map <Right> <Nop>
    map <Up> <Nop>
    map <Down> <Nop>
endif
