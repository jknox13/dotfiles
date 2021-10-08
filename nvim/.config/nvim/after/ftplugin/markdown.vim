setlocal spell spelllang=en_us

" ------------------------------------------
"  Goyo
" ------------------------------------------
function! s:goyo_enter()
  let b:quitting = 0
  let b:quitting_bang = 0
  autocmd QuitPre <buffer> let b:quitting = 1
  cabbrev <buffer> q! let b:quitting_bang = 1 <bar> q!

  " save on every change made
  w
  autocmd TextChanged,TextChangedI <buffer> silent write

  Limelight
  setlocal textwidth=80
  setlocal formatoptions+=t
  setlocal formatoptions-=l
  setlocal wrapmargin=2
endfunction

function! s:goyo_leave()
  " Quit Vim if this is the only remaining buffer
  if b:quitting && len(filter(range(1, bufnr('$')), 'buflisted(v:val)')) == 1
    if b:quitting_bang
      qa!
    else
      qa
    endif
  endif

  Limelight!
  setlocal textwidth=0
  setlocal formatoptions-=t
  setlocal formatoptions+=l
  setlocal wrapmargin=0
endfunction

autocmd! User GoyoEnter call <SID>goyo_enter()
autocmd! User GoyoLeave call <SID>goyo_leave()
