" Helper functions for the scripts should go here.

" Source a script based on its path relative to g:nvimroot.
function Source(path)
    exec 'source ' . g:nvimroot . '/' . a:path
endfunction

" Recursively source all .vim files inside the given directory.
function RecursiveSource(dir)
    for file in split(globpath(a:dir, '**/*.vim'), '\n')
        exec 'source ' . file
    endfor
endfunction

" Check if a variable exists and is true.
function IsFlagSet(name)
    return exists(a:name) && {a:name}
endfunction

