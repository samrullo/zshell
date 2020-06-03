if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = "pcl"
endif

"------------------------------------------------------------------------------
" Syntax definitions
"------------------------------------------------------------------------------

syntax include @Perl syntax/perl.vim

" Strings
syn match   pclInterpolation contained '\$\w*\({[a-zA-Z0-9._~-]\+}\)\?'
syn region  pclString contained start=+"+ end=+"+ contains=pclInterpolation

" Options
syn match   pclOption        contained '\([ |]\)\@<=-\w\+'
syn match   pclOptionWithArg contained '\([ |]\)\@<=-\w\+\>\( \+[^ -]\)\@='

" Basic delimiter and right-hand side
syn match   pclDelim contained '|' nextgroup=pclRHS skipwhite
syn match   pclRHS contained '[^|]\+' contains=pclSubcommand,pclFilter,pclInterpolation,pclString,pclOption,pclOptionWithArg nextgroup=pclDelim skipwhite

" Subcommand
syn match   pclSubcommand contained '\(| *\)\@<=[A-Z]\+' contains=pclSubKeyword nextgroup=pclRHS skipwhite
syn keyword pclSubKeyword contained LOAD PRI SYSTEM
syn keyword pclRunType contained CASHFLOWS DAILY EVOLVEPX FORCE FORCEDAILY OASSPDPX PMG PMGEXP SCENARIOS SPDPX SPREAD WEEKLY

" Filter
syn keyword pclFilterKeyword contained FILTER nextgroup=pclPerl skipwhite
syn match   pclFilter contained '\(| *\)\@<=FILTER[^|]*\(|\)\@=' contains=pclFilterKeyword nextgroup=pclDelim

" Variables
syn match   pclVariable '^[_-]\w\+' nextgroup=pclDelim skipwhite
syn match   pclPerlVariable '^\~\w\+' nextgroup=pclPerlDelim skipwhite

" Batch
syn match   pclBatch   '^[A-Z]\+[A-Za-z0-9:,_-]\+' contains=pclProgramType,pclProgram,pclWatchGroup nextgroup=pclDelim skipwhite
syn keyword pclProgramType contained XCMD BATCH
syn keyword pclProgram contained CNC Driver OAS PMS PSUM RA

" Watch groups
syn region  pclWatch start='->Watch_\?Groups' end='$' contains=pclWatchStatement,pclWatchGroup
syn match   pclWatchStatement contained '->Watch_\?Groups'
syn match   pclWatchGroup contained '\d\+'

" Perl evaluation
syn match   pclEvalStatement contained '^->eval' nextgroup=pclPerlDelim skipwhite
syn match   pclPerlDelim contained '|' nextgroup=pclPerl
syn match   pclPerl contained '[^|]\+' contains=@Perl nextgroup=pclDelim
syn match   pclEval '^->eval.*$' contains=pclEvalStatement

" Comments
syn keyword pclTodo contained TODO FIXME XXX NOTE
syn region  pclComment start='^\([#:]\|//\)' end='$' contains=pclTodo
syn region  pclRun oneline start='^:' end='$'

"------------------------------------------------------------------------------
" Highlighting
"------------------------------------------------------------------------------

" Top level
hi def link pclIdentifier     Identifier
hi def link pclKeyword        Keyword

" Variables
hi def link pclVariable       pclIdentifier
hi def link pclPerlVariable   pclVariable

" Strings
hi def link pclString         String
hi def link pclInterpolation  pclIdentifier
hi def link pclTodo           Todo
hi def link pclComment        Comment

" Commands
hi def link pclProgram        PreProc
hi def link pclProgramType    Define
hi def link pclWatchGroup     Number

hi def link pclRun            Comment
hi def link pclOptionWithArg  Type
hi def link pclOption         Operator

" Subcommands
hi def link pclFilterKeyword  pclKeyword
hi def link pclSubKeyword     pclKeyword
hi def link pclRunType        pclKeyword

" Watch groups
hi def link pclWatchStatement Statement

" Perl evaluation
hi def link pclEvalStatement  Statement

let b:current_syntax = "pcl"

if main_syntax == "pcl"
  unlet main_syntax
endif
