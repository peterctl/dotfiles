" Enable line numbers.
set number
if !IsFlagSet('g:relative_line_numbers')
    let g:relative_line_numbers = 0
endif

" Enables relative line numbers.
function s:EnableRelativeNumbers()
    let g:relative_line_numbers = 1
    set relativenumber
    augroup numbertoggle
        autocmd!
        autocmd BufEnter,FocusGained,InsertLeave,WinEnter * set relativenumber
        autocmd BufLeave,FocusLost,InsertEnter,WinLeave * set norelativenumber
    augroup END
endfunction

" Disables relative line numbers.
function s:DisableRelativeNumbers()
    let g:relative_line_numbers = 0
    set norelativenumber
    augroup numbertoggle
        autocmd!
    augroup END
endfunction

" Toggles relative line numbers.
function s:ToggleRelativeNumbers()
    if g:relative_line_numbers
        call s:DisableRelativeNumbers()
    else
        call s:EnableRelativeNumbers()
    endif
endfunction

" Command to toggle relative line numbers.
command! ToggleRelativeNumber call s:ToggleRelativeNumbers()
cnoreabbrev trn ToggleRelativeNumber

" Set line numbers at startup.
if g:relative_line_numbers
    call s:EnableRelativeNumbers()
else
    call s:DisableRelativeNumbers()
endif
