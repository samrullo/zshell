"------------------------------------------------------------------------------
" Intro
"------------------------------------------------------------------------------
if filereadable($VIMRUNTIME . "/syntax/syntax.vim")
  syntax enable
endif

colorscheme badwolf

" Disable background color erase for use in tmux
set t_ut=

" Load custom additions
if filereadable($HOME . "/.vimrc.before")
  source $HOME/.vimrc.before
endif

set nocompatible               " Turn off vi compatibility
filetype plugin on             " Enable filetype plugin
filetype indent on             " Enable indent pluing

set autoread                   " Autoread when file is changed
set hidden                     " Enable handling of multiple buffers
set history=1000               " Keep a longer history of commands
runtime macros/matchit.vim     " Extended % matching

set timeoutlen=500             " Wait 0.5 s for a key sequence to complete

set wildmode=longest:full      " Show all matches for tab-completing file names
set wildmenu                   " Show possible completions in command mode
set scrolloff=5                " Scroll when cursor is 5 lines from the bottom

let mapleader=","              " Easier to reach leader key

" Allow backspacing over indents, line breaks and the start of insert mode
set backspace=indent,eol,start

"------------------------------------------------------------------------------
" General
"------------------------------------------------------------------------------
" Navigate by display lines
nnoremap j gj
nnoremap k gk
vnoremap j gj
vnoremap k gk

" Fix busted up delete key
fixdel
function! Backspace()
  if col('.') == 1
    if line('.')  != 1
      return  "\<Esc>kA\<Del>"
    else
      return ""
    endif
  else
    return "\<Left>\<Del>"
  endif
endfunction
inoremap <Del> <C-R>=Backspace()<CR>

" Vertical diffing
nnoremap <leader>v :vnew<CR>:difft<CR><C-W>l:difft<CR><C-W>h

"------------------------------------------------------------------------------
" Emacs keybindings
"------------------------------------------------------------------------------
" let g:disable_emacs_keybindings = 1

"------------------------------------------------------------------------------
" Spacing
"------------------------------------------------------------------------------
set autoindent               " Copy current indent when starting a new line
set expandtab                " Convert a tab keypress into spaces
set smartindent              " Attempt to guess next line's indent level
set showmatch                " Jump to match when found

set number                   " Show line number
set ruler                    " Show line and column number in lower right

set listchars=tab:>-         " Show tabs as >---
set nowrap                   " No word wrap by default
set linebreak                " Break lines for wrapping on certain characters
set showbreak=>>>            " Give a wrapped line a hanging indent of >>>

set wrapmargin=0             " Turn off automatic insertion of newlines

set nojoinspaces             " Don't add two spaces between joined sentences

" Toggle text wrapping
nnoremap <leader>w :set wrap!<CR>

" List certain invisible characters
nnoremap <leader>l :set list<CR>

" Rehighlight text after indentation in visual mode
vnoremap < <gv
vnoremap > >gv

function! SetTextWidth(width)
  let &textwidth=a:width      " Maximum number of characters per line
  if exists("+colorcolumn")
    let &colorcolumn=a:width  " Show line break point if available
  endif
endfunction

function! SetIndent(level)
  let &shiftwidth=a:level     " Indent when hitting << and >>
  let &softtabstop=a:level    " Indent when hitting Tab in insert mode
  let &tabstop=a:level        " Number of spaces displayed for a tab character
endfunction

" Text width shortcuts
command! -nargs=1 SetTextWidth call SetTextWidth(<args>)
nnoremap <leader>0 :SetTextWidth 0<CR>
nnoremap <leader>8 :SetTextWidth 80<CR>

" Indent shortcuts
command! -nargs=1 SetIndent call SetIndent(<args>)
nnoremap <leader>2 :SetIndent 2<CR>
nnoremap <leader>3 :SetIndent 3<CR>
nnoremap <leader>4 :SetIndent 4<CR>

" Default to 2 spaces and 80 characters per line
call SetIndent(2)
call SetTextWidth(80)

" Use 4 spaces for Perl and Python
au FileType html_epl setl ts=4 et sw=4 sts=4
au FileType perl setl ts=4 et sw=4 sts=4
au FileType python setl ts=4 et sw=4 sts=4

" Use tabs equal to 8 spaces for C
au FileType cpp setl ts=8 noet sw=8 sts=8

" Use tabs equal to 4 spaces for Java and XML
au FileType java setl ts=4 noet sw=4 sts=4
au FileType xml setl ts=4 noet sw=4 sts=4

" Toggle paste on and off in normal and insert mode, and show the paste mode
" in the status section
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
set showmode

"------------------------------------------------------------------------------
" Language
"------------------------------------------------------------------------------
" Use Unicode if multi-byte is available
if has("multi_byte")
  " Make sure terminal encoding is set
  if &termencoding == ""
    let &termencoding=&encoding
  endif

  " Use UTF-8, but allow some other common encodings
  set encoding=utf-8
  setglobal fileencoding=utf-8
  set fileencodings=utf-8,utf-16,sjis,latin1,ucs-bom
endif

"------------------------------------------------------------------------------
" Colors and fonts
"------------------------------------------------------------------------------
" Hopefully someday we'll be able to see 256 colors
" set t_Co=256
" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm
" set t_Co=16

" Fix 16 color support
" if has("terminfo")
"   let &t_AB="\<Esc>[%?%p1%{8}%<%t%p1%{40}%+%e%p1%{92}%+%;%dm"
"   let &t_AF="\<Esc>[%?%p1%{8}%<%t%p1%{30}%+%e%p1%{82}%+%;%dm"
" else
"   let &t_Sf="\<Esc>[3%dm"
"   let &t_Sb="\<Esc>[4%dm"
" endif

"------------------------------------------------------------------------------
" CSV
"------------------------------------------------------------------------------
" Highlight a column in csv text
function! CSVH(colnr)
  if a:colnr > 1
    let n = a:colnr - 1
    execute 'match Keyword /^\([^,]*,\)\{'.n.'}\zs[^,]*/'
    execute 'normal! 0'.n.'f,'
  elseif a:colnr == 1
    match Keyword /^[^,]*/
    normal! 0
  else
    match
  endif
endfunction
command! -nargs=1 Csv :call CSVH(<args>)
nnoremap <leader>c :Csv<Space>

"------------------------------------------------------------------------------
" Files
"------------------------------------------------------------------------------
set nobackup                   " Don't create a permanent backup when writing
set nowritebackup              " Don't make a temporary backup either
set noswapfile                 " Don't use a swapfile for the buffer

" Easily switch between buffers
nnoremap <leader>b :buffers<CR>:buffer<Space>

" Open Perl module under cursor
function! LoadPerlModule(...)
  let name = a:0 > 0 ? a:1 : expand("<cWORD>")
  echo 'e `perldoc -lm '.name.'`'
  execute 'e `perldoc -lm '.name.'`'
endfunction
command! -nargs=? LoadPerlModule :call LoadPerlModule(<args>)
nnoremap <Leader>pm :LoadPerlModule<CR>

"------------------------------------------------------------------------------
" Regular expressions
"------------------------------------------------------------------------------
" Default searches to very magic (special characters don't need escaping)
nnoremap / /\v/<Left>
nnoremap ? ?\v/<Left>
nnoremap <leader>/ :%s/\v/g<Left><Left>
nnoremap <leader>; :%s/\v^\+.*\zs/g<Left><Left>

" Copy current word or selection and replace for the entire document
nnoremap <leader>s yiw:%s/\<<C-r>"\>//gc<Left><Left><Left>
vnoremap <leader>s y:%s/\<<C-r>"\>//gc<Left><Left><Left>

" Turn off search highlighting if it gets annoying
nnoremap <leader>n :nohlsearch<CR>

set ignorecase               " Case insensitive ...
set smartcase                " ... unless a capital letter is included
set incsearch                " Rematch search every keystroke
set hlsearch                 " Highlight search matches
set report=0                 " Notify how many replacements were made

"------------------------------------------------------------------------------
" Debugging
"------------------------------------------------------------------------------
" Show syntax highlighting groups for word under cursor
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo join(map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")'), " ")
endfunction
command! -nargs=0 SynStack call SynStack()
nmap <leader>h :SynStack<CR>

" Write ex command output to buffer
function! WriteExOutput(cmd)
  redir => message
  silent execute a:cmd
  redir END
  silent put=message
endfunction
command! -nargs=+ -complete=command WriteExOutput call WriteExOutput(<q-args>)
nmap <leader>e :WriteExOutput<Space>

"------------------------------------------------------------------------------
" Queries
"------------------------------------------------------------------------------
nnoremap <leader>i :w !/u1/bmckelve/perl/query.pl<CR>

"------------------------------------------------------------------------------
" Outro
"------------------------------------------------------------------------------
" Load custom additions
if filereadable($HOME . "/.vimrc.after")
  source $HOME/.vimrc.after
endif
