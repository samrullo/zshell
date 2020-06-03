" Because the clojure syntax file sucks
function! s:DetectClojure()
  if getline(1) == '#!/usr/bin/env lein-exec'
    set filetype=clojure
  endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectClojure()
au BufNewFile,BufRead *.clj set filetype=clojure
