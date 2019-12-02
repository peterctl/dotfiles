" Package Framework.
"
" This package framework splits configuration into packages. This framework
" works by splitting packages into groups, with each package being identified
" as 'group:package'. This group:package relationship is based on the
" directory structure used by the package framework, where a package group is
" configured to have a directory as its root, and each package within that
" group is a subdirectory. This means that if package group 'foo' has root
" '/foo' and package 'bar' belongs to the group 'foo', then package 'foo:bar'
" should be placed under '/foo/bar'. Each file inside a package is called a
" package section, and should be called '<section>.vim'. This means that
" section 'plugin' on package 'foo:bar' will be located at
" '/foo/bar/plugin.vim'. Each package has 3 sections:
"     - plugin: Plugin definitions for the package.
"     - config: Configuration done after the plugins are loaded.
"     - keymap: Key bindings.
" Key bindings are done on a different file for readability and organization.
" However, if a section is not found on a package, the file will not be
" sourced, so everyone is free to put both config and keybindings on the
" config section and nothing will happen.
"
" There are 3 predefined package roots in this framework:
"     - root: Root packages.
"     - lang: Packages related to different languages.
"     - local: Packages meant to be only within a given host.
" The root and lang packages are located inside this vim configuration
" structure, while the local group is located under '~/.local/nvim/config' by
" default. Package group configuration is done using the g:package_groups
" dictionary variable. To add a new group or modify an existing one, do this:
"     `g:package_groups[<package_group_name>] = <new_root>`
"
" To exclude a package from loading, use the g:exclude_packages list variable.
" Simply add the group:package identifier to the list. To exclude all
" packages in a group, then add 'group' to the list instead.
"
" Both group definitions and package exclusion can be done even before loading
" the init.vim bundled in this vim configuration, as the package framework
" assumes both the g:exclude_packages and the g:package_groups variables might
" be defined before init.vim is sourced.
"

function InitPackageFramework(nvim_root)
    if !exists('g:package_groups')
        let g:package_groups = {}
    endif

    if !exists('g:exclude_packages')
        let g:exclude_packages = []
    endif

    if !has_key(g:package_groups, 'core')
        let g:package_groups['core'] = a:nvim_root . '/pkg/core'
    endif
    if !has_key(g:package_groups, 'lang')
        let g:package_groups['lang'] = a:nvim_root . '/pkg/lang'
    endif
endfunction

function ResolvePackageList()
    let g:package_cache = []
    for [grp_name, grp_root] in items(g:package_groups)
        if index(g:exclude_packages, grp_name) >= 0
            continue
        endif
        for dir in globpath(grp_root, '*', 0, 1)
            if !isdirectory(dir)
                continue
            endif
            if index(g:exclude_packages, (grp_name . ':' . dir)) >= 0
                continue
            endif
            let g:package_cache = add(g:package_cache, fnamemodify(dir, ':p'))
        endfor
    endfor
    if index(g:exclude_packages, 'local') < 0
        let g:package_cache = add(g:package_cache, fnamemodify('~/.local/nvim', ':p'))
    endif
endfunction

function LoadSectionFromAllPackages(section)
    for package in g:package_cache
        let file = package . '/' . a:section . '.vim'
        if filereadable(file)
            exec 'source ' . file
        endif
    endfor
endfunction
