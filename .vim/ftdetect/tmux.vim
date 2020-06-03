autocmd BufNewFile,BufRead *.tmux.conf set ft=tmux
autocmd BufNewFile,BufRead *.tmux.conf setlocal commentstring=#\ %s
autocmd BufNewFile,BufRead */windows.tmux.* set ft=tmux
autocmd BufNewFile,BufRead */windows.tmux.* setlocal commentstring=#\ %s
