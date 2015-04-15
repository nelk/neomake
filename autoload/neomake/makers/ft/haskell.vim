
function! neomake#makers#ft#haskell#EnabledMakers()
    return ['ghcmod_check', 'ghcmod_lint']
endfunction

function! neomake#makers#ft#haskell#hdevtools()
    return {
        \ 'exe': 'hdevtools',
        \ 'args': ['check', '-g-Wall'],
        \ 'errorformat':
            \ '%-Z %#,'.
            \ '%W%f:%l:%v: Warning: %m,'.
            \ '%W%f:%l:%v: Warning:,'.
            \ '%E%f:%l:%v: %m,'.
            \ '%E%>%f:%l:%v:,'.
            \ '%+C  %#%m,'.
            \ '%W%>%f:%l:%v:,'.
            \ '%+C  %#%tarning: %m,'
        \ }
endfunction

function! s:ghcmod_maker(args, default_err_warn_type)
    " This filters out newlines, which is what neovim gives us instead of the
    " null bytes that ghc-mod sometimes spits out.
    let mapexpr = 'substitute(v:val, "\n", "", "g")'
    return {
        \ 'exe': 'ghc-mod',
        \ 'mapexpr': mapexpr,
        \ 'args': a:args,
        \ 'errorformat':
            \ '%-G%\s%#,' .
            \ '%f:%l:%c:%trror: %m,' .
            \ '%f:%l:%c:%tarning: %m,'.
            \ '%f:%l:%c: %trror: %m,' .
            \ '%f:%l:%c: %tarning: %m,' .
            \ a:default_err_warn_type . '%f:%l:%c:%m,' .
            \ a:default_err_warn_type . '%f:%l:%c:,' .
            \ '%Z%m'
        \ }
endfunction

function! neomake#makers#ft#haskell#ghcmod_check()
    return s:ghcmod_maker(['check'], '%E')
endfunction

function! neomake#makers#ft#haskell#ghcmod_lint()
    return s:ghcmod_maker(['lint'], '%W')
endfunction

function! neomake#makers#ft#haskell#hdevtools()
    return {
        \ 'exe': 'hdevtools',
        \ 'args': ['check', '-g-Wall'],
        \ 'errorformat':
            \ '%-Z %#,'.
            \ '%W%f:%l:%v: Warning: %m,'.
            \ '%W%f:%l:%v: Warning:,'.
            \ '%E%f:%l:%v: %m,'.
            \ '%E%>%f:%l:%v:,'.
            \ '%+C  %#%m,'.
            \ '%W%>%f:%l:%v:,'.
            \ '%+C  %#%tarning: %m,'
        \ }
endfunction

function! neomake#makers#ft#haskell#hlint()
    return {
        \ 'errorformat':
            \ '%E%f:%l:%v: Error: %m,' .
            \ '%W%f:%l:%v: Warning: %m,' .
            \ '%W%m'
        \ }
endfunction
