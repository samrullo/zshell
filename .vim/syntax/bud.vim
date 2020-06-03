if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = "bud"
endif

runtime! syntax/sql.vim
unlet! b:current_syntax

syn include @Perl syntax/perl.vim

"------------------------------------------------------------------------------
" Syntax definitions
"------------------------------------------------------------------------------

" Comments
syn keyword budTodo TODO FIXME XXX contained
syn region  budComment start='^ *[#:]' end='$' contains=budTodo

" Strings
syn region  budString start=+"+  skip=+\\\\\|\\"+  end=+"+ contains=budInterpolation
syn region  budString start=+'+  skip=+\\\\\|\\'+  end=+'+ contains=budInterpolation

" Missing SQL syntax
syn keyword budFunction     abs charindex convert left len inner outer right round
syn keyword budFunction     substring
syn keyword budKeyword      declare go join
syn match   budKeyword      '^ *\/ *$'
syn match   budTempTable    '\(^\|\)\@<=#\w\+'
syn keyword budType         int
syn keyword budStatement    while
syn match   budVariable     '@\w\+'

" Definitions
syn match   budPerlVariable '^\~\w\+'   nextgroup=budPerlDelim skipwhite
syn match   budPerlDelim    '|'         contained nextgroup=budPerl skipwhite
syn match   budPerl         '.*$'       contained contains=@Perl
syn match   budOption       '^[-_]\w\+' nextgroup=budDelim skipwhite
syn match   budDelim        '|'         contained nextgroup=budOptionDef skipwhite
syn match   budOptionDef    '.*$'       contained

" Bud interpolations
syn match   budTable        '<\w\+>'
syn region  budInterpolation start='\${' end='}'

"------------------------------------------------------------------------------
" Highlighting
"------------------------------------------------------------------------------

" Comments
hi def link budComment       Comment
hi def link budTodo          Todo

" Strings
hi def link budString        String

" Missing SQL syntax
hi def link budFunction      Function
hi def link budKeyword       Keyword
hi def link budStatement     Statement
hi def link budTempTable     budTable
hi def link budType          Type

" Definitions
hi def link budPerlVariable  budVariable
hi def link budOption        budVariable
hi def link budOptionDef     String

" Bud interpolations
hi def link budTable         Constant
hi def link budVariable      Identifier
hi def link budInterpolation Identifier

let b:current_syntax = "bud"

if main_syntax == "bud"
  unlet main_syntax
endif
