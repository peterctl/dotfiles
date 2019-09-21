" Wrapper around vim-plug (although this should be easy to modify to use
" another plugin provider) to allow for dependencies.

" Entries here should be {name, opts}.
let s:plugin_list = []

" Check if a plugin is defined in the list. If it is, return its index, else return -1.
function s:plugin_index(list, name)
    let idx = 0
    while idx < len(a:list)
        if a:list[idx]['name'] == a:name
            return idx
        endif
        let idx += 1
    endwhile
    return -1
endfunction

" Resolve plugin definitions into a list of plugins to install.
function s:resolve_list()
    let install_list = []

    " First pass to normalize opts.before and opts.after
    for plug in s:plugin_list
        let opts = get(plug, 'opts', 0)
        if type(opts) != v:t_dict
            continue
        endif
        let before = get(opts, 'before', [])
        for pbef in before
            let idx = s:plugin_index(s:plugin_list, pbef)
            let opts = get(s:plugin_list[idx], 'opts', 0)
            if type(opts) != v:t_dict
                let opts = {}
            endif
            let after = get(opts, 'after', [])
            let opts['after'] = add(after, plug['name'])
            let s:plugin_list[idx]['opts'] = opts
        endfor
    endfor

    " Now add the plugins to install_list in the correct order.
    let old_list = s:plugin_list
    let new_list = []
    while !empty(old_list)
        for plug in old_list
            let should_install = 1
            let opts = get(plug, 'opts', 0)
            if type(opts) == v:t_dict
                let after = get(opts, 'after', [])
                if type(after) == v:t_string
                    let after = [after]
                endif
                for paft in after
                    if s:plugin_index(install_list, paft) < 0
                        if s:plugin_index(s:plugin_list, paft) < 0
                            echom 'Plugin ' . paft . ' not found (dependency of ' . plug['name'] . ')'
                            continue
                        endif
                        let should_install = 0
                        break
                    endif
                endfor
            endif
            if should_install
                " We use deepcopy here so that s:resolve_list
                " can be called multiple times without
                " mutating s:plugin_list
                let install_list = add(install_list, deepcopy(plug))
            else
                let new_list = add(new_list, plug)
            endif
        endfor
        let old_list = new_list
        let new_list = []
    endwhile

    " Remove opts.before and opts.after from Plugin definitions so that
    " Plug only handles its relevant options
    for plug in install_list
        if type(plug['opts']) != v:t_dict
            continue
        endif
        if has_key(plug['opts'], 'before')
            unlet plug['opts']['before']
        endif
        if has_key(plug['opts'], 'after')
            unlet plug['opts']['after']
        endif
        if empty(plug['opts'])
            let plug['opts'] = 0
        endif
    endfor

    return install_list
endfunction

" Add a plugin definition.
function s:plugin(replace, name, ...)
    if a:0 > 1
        echoerr 'Too many arguments in call to s:plugin'
    endif
    " Ignore if it's already defined and we don't want to replace
    let idx = s:plugin_index(s:plugin_list, a:name)
    let opts = a:0 == 1 ? a:1 : 0
    if idx >= 0
        if !a:replace
            echoerr 'Plugin [' . a:name . '] is already defined.'
            return
        endif
        let s:plugin_list[idx] = {'name': a:name, 'opts': opts}
    endif
    let s:plugin_list = add(s:plugin_list, {'name': a:name, 'opts': opts})
endfunction

function LoadPlugins()
    let install_list = s:resolve_list()
    for plug in install_list
        if type(plug['opts']) == v:t_dict
            Plug plug['name'], plug['opts']
        else
            Plug plug['name']
        endif
    endfor
endfunction

command -bang -bar -nargs=+ Plugin call s:plugin(<bang>0, <args>)
