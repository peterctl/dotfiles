" Airline configuration.

function! s:HumanReadable(section)
    return substitute(a:section, '\d\@<=\(\(\d\{3\}\)\+\)$', ',&', 'g')
endfunction

function! s:LinePercent()
    return line('.') * 100 / line('$')
endfunction

function! FileInfo()
    if IsFlagSet('g:airline_powerline_fonts')
        return s:LinePercent() . '%'
            \. " \uE0A1:" . s:HumanReadable(line('.')) . '/' . s:HumanReadable(line('$'))
            \. " \uE0A3:" . s:HumanReadable(virtcol('.')) . '/' . s:HumanReadable(virtcol('$'))
    else
        return s:LinePercent() . '%'
            \. " ln:" . s:HumanReadable(line('.')) . '/' . s:HumanReadable(line('$'))
            \. " cn:" . s:HumanReadable(virtcol('.')) . '/' . s:HumanReadable(virtcol('$'))
    endif
endfunction

" Setup custom file info section.
call airline#parts#define('FileInfoPart', {'function': 'FileInfo'})
let g:airline_section_z = airline#section#create(['FileInfoPart'])

" Airline settings.
" Another cool separator: ▒
let g:airline_right_sep = ''
let g:airline_left_sep = ''
let g:airline_right_alt_sep = '|'
let g:airline_left_alt_sep = '|'

" Tabline settings.
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline#extensions#tabline#buffer_nr_show = 1

" Tmuxline settings.
" let g:tmuxline_separators = {
"     \ 'left': '',
"     \ 'left_alt': '|',
"     \ 'right': '',
"     \ 'right_alt': '|',
"     \ 'space': ' ',
" \ }
