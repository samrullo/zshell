if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = "bql"
endif

"------------------------------------------------------------------------------
" Syntax definitions
"------------------------------------------------------------------------------

" Numbers
syn match   bqlNumber contained '[0-9]\+\(\.[0-9]\+\)\?'

" Strings
syn region  bqlString contained start=+"+ end=+"+ contains=bqlRegex
syn region  bqlString contained start=+'+ end=+'+ contains=bqlRegex

" Keywords
syn keyword bqlNull contained NULL

" Groups
syn region  bqlGroup contained start='(' end =')' contains=bqlString,bqlNumber skipwhite

" Comparisons
syn match   bqlComparison '[><]=\?\|!\?[=~]' nextgroup=bqlNumber,bqlString,bqlNull skipwhite
syn match   bqlInclusion  '!\??' nextgroup=bqlGroup skipwhite

" References
syn region  bqlReference start='{' end='}'

" Types
syn match   bqlStringType '$[A-Za-z0-9_-]\+'
syn match   bqlNumberType '#[A-Za-z0-9_-]\+'
syn match   bqlInteger    ':[A-Za-z0-9_-]\+'
syn match   bqlDate       '@[A-Za-z0-9_-]\+'
syn match   bqlDefault    '%[A-Za-z0-9_-]\+'


"------------------------------------------------------------------------------
" Highlighting
"------------------------------------------------------------------------------

" Numbers
hi def link bqlNumber     Number

" Strings
hi def link bqlString     String

" Keywords
hi def link bqlNull       Special

" References
hi def link bqlReference  PreProc

" Types
hi def link bqlVariable   Identifier
hi def link bqlStringType bqlVariable
hi def link bqlNumberType Constant
hi def link bqlInteger    bqlNumberType
hi def link bqlDate       Type
hi def link bqlDefault    bqlVariable

let b:current_syntax = "bql"

if main_syntax == "bql"
  unlet main_syntax
endif
