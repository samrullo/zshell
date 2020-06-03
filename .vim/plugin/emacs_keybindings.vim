" Set defaults
function! <SID>LetDefault(var_name, value)
  if !exists(a:var_name)
    execute 'let ' . a:var_name . '=' . a:value
  endif
endfunction
command! -nargs=+ LetDefault call s:LetDefault(<f-args>)

LetDefault g:enable_emacs_keybindings 1

finish
if g:enable_emacs_keybindings == 0 || exists("loaded_emacs_keybindings")
  finish
endif

"------------------------------------------------------------------------------
" Ctrl keybindings
"------------------------------------------------------------------------------
inoremap <C-a> <Home>
inoremap <C-b> <Left>
inoremap <C-d> <Del>
inoremap <C-e> <End>
inoremap <C-f> <Right>
inoremap <C-h> <BS>
inoremap <C-k> <C-o>D
inoremap <C-n> <Down>
inoremap <C-p> <Up>
inoremap <C-u> <C-o>d0
" inoremap <C-v> <PageDown>
inoremap <Esc>[D <C-o>b
inoremap <Esc>[C <C-o>e<Right>
inoremap <C-BS> <C-w>

"------------------------------------------------------------------------------
" Meta/Alt keybindings
"------------------------------------------------------------------------------
" Instantaneous recognition of Escape. Without this Alt keybindings will cause
" Vim to wait for further keypresses, which delays exits from insert mode and
" messes up key macros
set timeoutlen=1000 ttimeoutlen=0

inoremap <Esc>a <C-o>(
inoremap <Esc>b <C-o>b
inoremap <Esc>d <C-o>de
inoremap <Esc>e <C-o>)
inoremap <Esc>f <C-o>e<Right>
inoremap <Esc>h <C-w>
inoremap <Esc>v <PageUp>
inoremap <Esc>x <C-o>:
" inoremap <Esc><BS> <C-w>

"------------------------------------------------------------------------------
" Other keybindings
"------------------------------------------------------------------------------
" C-x keybindings
inoremap <C-x><C-c> <C-o>:confirm qall<CR>
inoremap <C-x><C-s> <C-o>:w<CR>
inoremap <C-x><C-u> <C-o>u

" Other
inoremap <C-r> <C-o>?\v/<Left>
inoremap <C-s> <C-o>/\v/<Left>
