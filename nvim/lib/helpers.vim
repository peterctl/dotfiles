" Helper functions for the scripts should go here.

" Check if a variable exists and is true.
function IsFlagSet(name)
    return exists(a:name) && {a:name}
endfunction

