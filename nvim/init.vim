let g:spacevim_colorscheme = "onedark"
let g:spacevim_colorscheme_bg = "dark"
let g:spacevim_enable_guicolors = 1
let g:spacevim_statusline_separator = "nil"
let g:spacevim_statusline_inactive_separator = "nil"
let g:spacevim_buffer_index_type = 4
let g:spacevim_enable_tabline_filetype_icon = 1
let g:spacevim_enable_statusline_mode = 1
let g:spacevim_default_indent = 4
" let g:spacevim_filemanager = "defx"

let g:_spacevim_bootstrap_before = "BootstrapBefore"
let g:_spacevim_bootstrap_after = "BootstrapAfter"

let g:spacevim_custom_plugins = [
  \ [ "tpope/vim-sleuth", { "merged": 0 } ],
  \ [ "sgur/vim-editorconfig", { "merged": 0 } ],
  \ ]

call SpaceVim#layers#load("autocomplete", {
  \ "auto-completion-return-key-behavior": "nil",
  \ "auto-completion-tab-key-behavior": "cycle",
  \ })
call SpaceVim#layers#load("colorscheme")
call SpaceVim#layers#load("denite")
call SpaceVim#layers#load("fzf")
call SpaceVim#layers#load("git")
call SpaceVim#layers#load("incsearch")
call SpaceVim#layers#load("indentmove")
call SpaceVim#layers#load("lang#c")
call SpaceVim#layers#load("lang#go")
call SpaceVim#layers#load("lang#rust")
call SpaceVim#layers#load("lsp")
call SpaceVim#layers#load("operator")
call SpaceVim#layers#load("shell", {
  \ "default-position": "top",
  \ "default-height": 30,
  \ })
call SpaceVim#layers#load("tools")
call SpaceVim#layers#load("VersionControl")

let g:delimitMate_expand_cr = 1
let g:delimitMate_expand_space = 1

let g:indentLine_showFirstIndentLevel = 1
let g:indentLine_char = '┊'
let g:indentLine_first_char = g:indentLine_char
if &term is# "linux"
  let g:indentLine_enabled = 0
endif

set list

" Enable changing cursor outside neovim
if !has('nvim')
  let &t_EI = "\e[1 q"
  let &t_SI = "\e[5 q"
endif

function! BootstrapAfter()
  noremap <C-E> 3<C-E>
  set scrolloff=3
  set sidescrolloff=3
  set whichwrap=b,s,h,l,[,],<,>
  set listchars=tab:›\ ,eol:¬,trail:⋅,nbsp:•,extends:>,precedes:<
  call SpaceVim#layers#core#statusline#register_sections("cursorpos", {-> " %{StatuslineCursorPos()} "})
endfunction

function s:hrn(n)
  return substitute(a:n, '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

function StatuslineCursorPos()
  " let _l = "\uE0A1:"
  " let _c = "\uE0A3:"
  return s:hrn(line('.')) . "/" . s:hrn(line('$')) . " : " . s:hrn(col('.')) . "/" . s:hrn(col('$'))
endfunction
