" Because the zsh syntax file sucks
function! s:DetectZsh()
  if getline(1) == '#!/usr/bin/env zsh'
    set filetype=sh
  endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectZsh()
autocmd BufNewFile,BufRead *.zsh set filetype=zsh
