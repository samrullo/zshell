fpath=("$(dirname $0)" $fpath)

_COMPLETIONS=~/.zsh_blackrock_completions
_CONFIG=~/.zsh_blackrock_config

if [[ -f $_CONFIG ]]; then
  source $_CONFIG
else
  cat <<END
No configuration file found for BlackRock zsh tab completions. I'll create one
for you in
$_CONFIG

When you get a chance, fill it out with your favorites and run
generate_blackrock_completions

Until then, completion for funds and other goodies won't work.
END

  cat >> $_CONFIG <<END
# Example:
#
# packages=(EINX-TW ETK-ALL MTK-ALL)
#
# Once set, run the following in your terminal and wait a bit:
#   generate_blackrock_completions

packages=()
END
fi

[[ -f $_COMPLETIONS ]] && source $_COMPLETIONS

_write_completion () { 
  local key values
  key=$1
  shift
  values="$*"
  print "_blackrock_$key=($values)" >> $_COMPLETIONS
}

_parse_portfolio_groups () {
  perl -ne 'next unless /2 *$/; s/^ ([^ ]+ ) *2 *$/\1/; chomp; print'
}

_get_portfolio_groups () {
  local packages='"'${(j:", ":)@}'"'

  isql -w132 <<END |& _parse_portfolio_groups
select portfolio_name, 0 as flag
into #ports
from portdb.dbo.portfolios
where portfolio_name in ($packages)

while (select count(1) from #ports where flag = 0) > 0
begin
    update #ports set flag = 1 where flag = 0

  insert into #ports
  select pg.portfolio_name, 0
  from #ports b
  inner join portdb.dbo.port_group pg
      on b.portfolio_name = pg.portfolio_group
  where b.flag = 1
      and pg.portfolio_group <> pg.portfolio_name

  update #ports set flag = 2 where flag = 1
end

select distinct portfolio_name, flag from #ports

drop table #ports

go
END
}

generate_blackrock_completions () {
  cat /dev/null > $_COMPLETIONS

  _write_completion clients $Bfm/clients/*/(:t)

  (( $+packages )) && _write_completion funds $(_get_portfolio_groups $packages)

  _write_completion pcls \
    $Bfm/clients/*/std/GreenPkg/*.pcl(:gs#$Bfm/clients/##:gs#/std/GreenPkg/#::)
  source $_COMPLETIONS
}

# }}}
# Utility functions {{{1
_blackrock_values () {
  local key values
  key="_blackrock_${(P)#}"
  values=(${(P)key})

  for i in $values
  do
    compadd $i
  done
}

_weekdays () {
  _values '' $(perl5.8 -MPOSIX=strftime -e 'my @t = localtime;
    for (my $i = 0; $i < 7; $i++) {
      $t[3]--;
      $t[6]--;
      $t[6] = 6 if $t[6] < 0;
      my $s = strftime("%m/%d/%Y", @t);
      $s =~ s/(?<!\d)0//g;
      print $s, "\n" unless $t[6] == 0 || $t[6] == 6;
    }')
}

# }}}
_port_group_or_fund=(
  "(-pg)-fund[fund name]: :_blackrock_values funds"
  "(-fund)-pg[portfolio group name]: :_blackrock_values funds"
)
_sec_group_sec_types=(
  ABS ABS.ABS ABS.AGENCY ABS.OPICTBA ARM ARM.GENERIC ARM.POOL ARM.SERV ARM.TBA
  BND BND.AGENCY BND.CBO BND.CORP BND.COVER BND.GENERIC BND.GOVT BND.LOCAL
  BND.MUNI BND.MUNITAX BND.PERP BND.RES CASH CASH.AGENCY CASH.BA CASH.CASH
  CASH.CD CASH.COLLATERAL CASH.CP CASH.CPLG CASH.MUNI CASH.MUNICP CASH.MVRDN
  CASH.REP CASH.RRP CASH.SAVR CASH.TBILL CASH.TD CASH.TFN CDI CDI.AGENCY CF
  CF.BND CLC CLC.LOAN CLC.TRANCHE CMBS CMBS.LOAN CMBS.SENIOR CMBS.SUB CMDTY
  CMDTY.GOLD CMDTY.OIL CMDTY.PLATINUM CMDTY.SILVER CMO CMO.AGENCY CMO.CDI
  CMO.DEAL CMO.GENERIC CMO.RES CMO.WHOLE EQUITY EQUITY.EQUITY EQUITY.NOTE
  EQUITY.PFD EQUITY.WARRANT FUND FUND.CLOSED_END FUND.COMPOSITE FUND.INDEX
  FUND.OPEN_END FUND.REIT FUND.STIF FUTURE FUTURE.CFD FUTURE.FIN FUTURE.GENERIC
  FUTURE.INDEX FX FX.FWRD FX.HEDGE FX.SPOT IBND IBND.AGENCY IBND.CORP IBND.GOVT
  INDEX INDEX.GENERIC INDEX.INDEX INS INS.FPDA INS.SPDA JRNL JRNL.DVD JRNL.RDM
  LOAN LOAN.AMORT LOAN.LEVPRIN LOAN.REVOLVE LOAN.TERM MBS MBS.AGGREGATE
  MBS.APROJ MBS.GENERIC MBS.MULTI MBS.POOL MBS.SERV MBS.TBA OPTION OPTION.CUROTC
  OPTION.EQUITY OPTION.FUTURE OPTION.GENERIC OPTION.OTC PORT PORT.COMPOSITE
  PORT.FUND RE RE.PROP SWAP SWAP.ASWAP SWAP.CDSWAP SWAP.CMOSWAP SWAP.CSWAP
  SWAP.INDEXSWAP SWAP.SWAP SWAP.TRSWAP SYNTH SYNTH.CAP SYNTH.FLOOR SYNTH.INDEX
  SYNTH.OTC SYNTH.SWAPTION
)

# Autoload all completion functions in this directory
autoload -U compinit && compinit -u
