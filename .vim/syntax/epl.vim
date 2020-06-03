" html w/ Perl as a preprocessor
" Language:    Perl + html
" Maintainer:  yko <ykorshak@gmail.com>
" Version:     0.02_0
" Last Change: 2010 Nov 14
" Location:    http://github.com/yko/Vim-Mojo-Data-syntax
" Original version: vti <vti@cpan.org>

if !exists("main_syntax")
  let main_syntax = 'epl'
endif

if exists("perl_fold") 
  let bfold = perl_fold
  unlet perl_fold
endif

unlet b:current_syntax
syn include @Perl syntax/perl.vim

syn cluster htmlPreproc add=PerlInside

syn keyword embperlMeta contained if elsif else endif while endwhile do until foreach endforeach hidden var sub endsub
syn region PerlInside matchgroup=Tags start="\[+"rs=s end="+\]"re=e contains=@Perl
syn region PerlInside matchgroup=Tags start=+\[-+rs=s end=+-\]+re=e contains=@Perl
syn region PerlInside matchgroup=Tags start=+\[!+rs=s end=+!\]+re=e contains=@Perl
syn region PerlInside matchgroup=Tags start=+\[\$+rs=s end=+\$\]+re=e contains=embperlMeta, perlConditional, perlOperator

hi link embperlMeta     perlStatement

hi def link MojoStart Identifier
hi def link MojoEnd   Identifier

let b:current_syntax = "epl"
if exists("bfold") 
    perl_fold = bfold
    unlet bfold
endif
