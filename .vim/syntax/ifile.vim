if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = "ifile"
endif

"------------------------------------------------------------------------------
" Syntax definitions
"------------------------------------------------------------------------------

syntax include @BQL syntax/bql.vim

" Options
syn match   ifileOption '^:[A-Za-z0-9_]\+' nextgroup=ifileRHS skipwhite

" Action data and switches
syn match   ifileFreeData contained '.\+'
syn keyword ifileData_d contained a n y F f P g s m c 3 M D t
syn keyword ifileData_r contained A c C d e E m n o p P pos r R s T t w
syn keyword ifileData_c contained % Cash CashEquiv CleanCash CommittedCash CommittedCsh Counterparty D DBRisk DBSafe DIETZNAV EQ_SOD LTFundExclTags LTOverlay M NotlCashAutoCollapse Orders P PESL_DIR ShowAllSectors SpendableCash a c d expert g h hdr_ccys k m notl_cash_offsets p pnl_mode port_currency rpt_types sniper_mode swap_hedge_lookthrough
syn keyword ifileData_C contained c r reload
syn keyword ifileData_g contained b s i t
syn keyword ifileData_s contained summary detail
syn keyword ifileData_t contained m r
syn keyword ifileData_V contained barra_hi decomp_schema exp_hi var_basis var_decay_daily var_fi_eq var_split var_type

syn keyword ifileData_u contained b c d h p r R t

" Filters
syn match   ifileBQL contained '.\+' contains=@BQL

" Toggles
syn keyword ifileOn          contained ON
syn keyword ifileOff         contained OFF
syn keyword ifileOnLC        contained on
syn keyword ifileOffLC       contained off
syn keyword ifileY           contained Y
syn keyword ifileN           contained N

" Sector data
syn match   ifilePMS2DB        contained '[A-Za-z0-9_,-]\+'
syn match   ifileBreakdowns2DB contained '[A-Za-z0-9_,-]\+' nextgroup=ifilePMS2DB skipwhite
syn keyword ifileSectorData    contained sector_data nextgroup=ifileBreakdowns2DB skipwhite

" Lookthrough
syn match   ifileBreakdowns    contained '[A-Za-z0-9_,-]\+'
syn keyword ifileOnBreakdowns  contained ON nextgroup=ifileBreakdowns skipwhite
syn keyword ifileOffBreakdowns contained OFF nextgroup=ifileBreakdowns skipwhite
syn keyword ifileLTOverlay     contained LTOverlay nextgroup=ifileOnBreakdowns,ifileOffBreakdowns skipwhite
syn keyword ifileLTExTags      contained LTFundExclTags nextgroup=ifileOnBreakdowns,ifileOffBreakdowns skipwhite
syn keyword ifileLTSwapHedge   contained swap_hedge_lookthrough nextgroup=ifileY,ifileN skipwhite

" Reports
syn match   ifileReportTag     contained '[^ .]\+' nextgroup=ifileReportDelim
syn match   ifileReportDelim   contained '.' nextgroup=ifileReportDepth,ifileBreakdown
syn match   ifileBreakdown     contained '[A-Za-z0-9_,-]\+'
syn match   ifileReportDepth   contained '[123]' nextgroup=ifileReportDelim2
syn match   ifileReportDelim2  contained '.' nextgroup=ifileBreakdown

" Actions
syn match   ifileAction '^\([efhqDGTX]\|ignorePublish\|rpt_version\)\>' nextgroup=ifileFreeData skipwhite
syn match   ifileAction_d '^d\>' nextgroup=ifileData_d skipwhite
syn match   ifileAction_f '^f\>' nextgroup=ifileBQL skipwhite
syn match   ifileAction_r '^r\>' nextgroup=ifileData_r skipwhite
syn match   ifileAction_c '^c\>' nextgroup=ifileData_c,ifileLTOverlay,ifileLTExTags,ifileLTSwapHedge skipwhite
syn match   ifileAction_C '^C\>' nextgroup=ifileData_C skipwhite
syn match   ifileAction_g '^g\>' nextgroup=ifileData_g skipwhite
syn match   ifileAction_s '^s\>' nextgroup=ifileData_s skipwhite
syn match   ifileAction_S '^S\>' nextgroup=ifileBQL skipwhite
syn match   ifileAction_t '^t\>' nextgroup=ifileData_t skipwhite
syn match   ifileAction_V '^V\>' nextgroup=ifileData_V skipwhite
syn match   ifileAction_u '^u\>' nextgroup=ifileData_u,ifileSectorData skipwhite
syn match   ifileAction_W '^W\>' nextgroup=ifileReportTag skipwhite
syn match   ifileAction_split '^split\(_sec\)\?-' nextgroup=ifileOnLC,ifileOffLC
syn match   ifileAction_suppress '^suppress\>' nextgroup=ifileOn,ifileOff,ifileOnLC,ifileOffLC skipwhite

" Right-hand side
syn match   ifileRHS contained '.\+'

" Comments
syn region  ifileComment start='^#' end='$'

"------------------------------------------------------------------------------
" Highlighting
"------------------------------------------------------------------------------

" Variables
hi def link ifileBreakdowns    Identifier
hi def link ifileBreakdowns2DB ifileBreakdowns
hi def link ifilePMS2DB        Type

" Strings
" hi def link pclString         String
" hi def link pclInterpolation  pclIdentifier
" hi def link pclTodo           Todo
hi def link ifileComment      Comment

" Action data and switches
hi def link ifileData            String
hi def link ifileData_d          ifileData
hi def link ifileData_r          ifileData
hi def link ifileData_c          ifileData
hi def link ifileData_C          ifileData
hi def link ifileData_g          ifileData
hi def link ifileData_s          ifileData
hi def link ifileData_t          ifileData
hi def link ifileData_V          ifileData
hi def link ifileData_u          ifileData
hi def link ifileData_suppress   ifileData

" Toggles
hi def link ifileOn              PreProc
hi def link ifileOff             Keyword
hi def link ifileOnLC            ifileOn
hi def link ifileOffLC           ifileOff
hi def link ifileY               ifileOn
hi def link ifileN               ifileOff

" Sector data
hi def link ifileSectorData      ifileData

" Lookthrough overlay
hi def link ifileLTOverlay       ifileData
hi def link ifileOnBreakdowns    ifileOn
hi def link ifileOffBreakdowns   ifileOff
hi def link ifileLTExTags        ifileData
hi def link ifileLTSwapHedge     ifileData

" Reports
hi def link ifileReportTag       String
hi def link ifileReportDepth     Number
hi def link ifileBreakdown       ifileBreakdowns

" Actions
hi def link ifileAction          PreProc
hi def link ifileAction_d        ifileAction
hi def link ifileAction_f        ifileAction
hi def link ifileAction_r        ifileAction
hi def link ifileAction_c        ifileAction
hi def link ifileAction_C        ifileAction
hi def link ifileAction_g        ifileAction
hi def link ifileAction_s        ifileAction
hi def link ifileAction_S        ifileAction
hi def link ifileAction_t        ifileAction
hi def link ifileAction_V        ifileAction
hi def link ifileAction_u        ifileAction
hi def link ifileAction_W        ifileAction
hi def link ifileAction_split    ifileAction
hi def link ifileAction_suppress ifileAction

hi def link ifileOption       Operator

let b:current_syntax = "ifile"

if main_syntax == "ifile"
  unlet main_syntax
endif
