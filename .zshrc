################################################################################
# Before hook
################################################################################
[ -f ~/.zshrc.before ] && source ~/.zshrc.before

################################################################################
# General
################################################################################
# Use reasonably sane terminal keys
stty sane

case "$TERM" in
  "dumb")
  PS1="> "
  exit
  ;;
esac

# Don't wait for additional characters in a sequence, like escape codes
KEYTIMEOUT=1

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Complete aliases. Worst variable name ever.
setopt no_complete_aliases

# Set name of the theme to load
ZSH_THEME="brymck"

# Comment this out to disable weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Comment following line if you don't want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
# plugins=(perl ruby svn vim)

# Load BlackRock tab completions
#source $ZSH/plugins/blackrock/blackrock.zsh

# Automatically show matches less than or equal to LISTMAX
LISTMAX=500
export SHELL=/bin/zsh
export QTR_RES_ENV=production

# Use BlackRock's web proxy for external web requests
export HTTP_PROXY='http://webproxy.bfm.com:8080'
export HTTPS_PROXY='http://webproxy.bfm.com:8080'
export http_proxy='http://webproxy.bfm.com:8080'

# Defaults for reports
export RPT_DIR="/d0/prod1/reports/$USER"
export DREAM_CNC="$Bfm/clients/BLK/std/GreenPkg/ifiles/dream_cnc.ifile"
export DREAM_PMS="$Bfm/clients/BLK/std/GreenPkg/ifiles/dream_pms.ifile"

source $ZSH/oh-my-zsh.sh

################################################################################
# Terminal
################################################################################
# Unless we're in tmux, check whether a 256-color terminal exists
if [ ! -n "$TMUX" ]; then
  local term=xterm
  for dir in /usr/{,share/}{,lib/}terminfo; do
    if [ -f $dir/x/xterm-256color ]; then
      term=xterm-256color
      break
    fi
  done
  export TERM=$term
fi

# Non-fugly ls colors
LS_COLORS='di=34;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;'

################################################################################
# Path
################################################################################
# The global .cshrc file makes the incredibly stupid, insecure addition of . to
# your path. Hell no.
export PATH="${PATH//:./}"

# Add my stuff to PATH
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/etc:$PATH"
export PATH="$HOME/local:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/local/etc:$PATH"
export PATH="$HOME/perl:$PATH"
export PATH="$HOME/perl5/bin:$PATH"
export PATH="$HOME/ruby:$PATH"
export PATH="$HOME/tools:$PATH"
export PATH="$HOME/zsh:$PATH"
export MANPATH="$HOME/local/share/man:$MANPATH"

# System
export PATH="/bin:$PATH"
export PATH="/etc:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/usr/openwin/bin:$PATH"
export PATH="/usr/ucb:$PATH"

# Local
export PATH="/usr/local/bfm/bin:$PATH"
export PATH="/usr/local/bfm/clients/BLK/etc:$PATH"
export PATH="/usr/local/bfm/clients/DEV/etc:$PATH"
export PATH="/usr/local/bfm/etc:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/etc:$PATH"
export PATH="/usr/local/sybase/bin:$PATH"

# Vim
export PATH="/usr/local/bin/vim72:$PATH"

# Whatever, Perl
export PATH="/usr/local/ext/perl/site_perl/5.12.4/bin:$PATH"
export PATH="/usr/local/ext/perl/vendor_perl/5.12.4/bin:$PATH"
export PATH="/usr/local/perl/5.12.4/bin:$PATH"
export PERL5LIB="$HOME/perl5/lib/perl5"

# Yeah, Ruby!
export PATH="$HOME/.ruby/bin:$PATH"
export PATH="/opt/local/pkgs/ruby-1.8.7-p249/bin:$PATH"
export PATH="/opt/local/pkgs/ruby-1.8.7-p352/bin:$PATH"
export PATH="/opt/local/pkgs/rubygems-1.3.6/bin:$PATH"
export PATH="/opt/local/pkgs/rubygems-1.3.6/lib:$PATH"
export GEM_HOME="$HOME/.ruby/gems"
export GEM_PATH="$HOME/.ruby"
export RUBYLIB="$HOME/.ruby"

# Okay, Python
export PATH="$HOME/java:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bfm/lib/python:$PATH"
export PATH="/usr/local/bfm/apps:$PATH"

# Hrngh, Java
export PATH="/usr/local/java/jre_8u5_x64/bin:$PATH"

# Build tools
export PATH="/usr/local/devtools/autoconf/bin:$PATH"
export PATH="/usr/local/devtools/automake/bin:$PATH"
export PATH="/usr/local/devtools/binutils/bin:$PATH"
export PATH="/usr/local/devtools/ccache/bin:$PATH"
export PATH="/usr/local/devtools/ddd/bin:$PATH"
export PATH="/usr/local/devtools/distcc/bin:$PATH"
export PATH="/usr/local/devtools/gcc/bin:$PATH"
export PATH="/usr/local/devtools/gdb/bin:$PATH"
export PATH="/usr/local/devtools/gmake/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/devtools/gcc/lib:$LD_LIBRARY_PATH"
export MANPATH="/usr/local/devtools/autoconf/man:$MANPATH"
export MANPATH="/usr/local/devtools/automake/man:$MANPATH"
export MANPATH="/usr/local/devtools/binutils/man:$MANPATH"
export MANPATH="/usr/local/devtools/ccache/man:$MANPATH"
export MANPATH="/usr/local/devtools/ddd/man:$MANPATH"
export MANPATH="/usr/local/devtools/distcc/man:$MANPATH"
export MANPATH="/usr/local/devtools/gcc/man:$MANPATH"
export MANPATH="/usr/local/devtools/gdb/man:$MANPATH"
export MANPATH="/usr/local/devtools/gmake/man:$MANPATH"

################################################################################
# OS duct tape
################################################################################
# less does not support the -R option, which zsh uses as default
export PAGER=less

# Solaris ls is crap
ls --color 1>/dev/null 2>&1
if [[ $? == 0 ]]; then
  alias ls='ls -F --color=always'
else
  alias ls='ls -F'
fi

################################################################################
# Autocorrect
################################################################################
# I give up
unsetopt correct_all

# Prevent zsh from taking forever with ssh, scp, etc.
#zstyle -e ':completion:*' hosts 'reply=()'
zstyle ':completion:*' hosts off

################################################################################
# Keybindings
################################################################################
# Make Ctrl-P and Ctrl-N behave more like Up and Down, respectively
bindkey '^P' up-line-or-search
bindkey '^N' down-line-or-search

# Pattern-based history search
bindkey '^R' history-incremental-pattern-search-backward

################################################################################
# Vim
################################################################################
set_vim() {
  alias vim=$1
  alias vimdiff=$2
  export EDITOR=$1
}

if [ -f /usr/local/bin/vim72 ]; then  # Newer environments
  set_vim /usr/local/bin/vim72 /usr/local/bin/vimdiff
elif [ -f /usr/bin/vim ]; then        # Linux
  set_vim /usr/bin/vim /usr/bin/vimdiff
fi

################################################################################
# Clients
################################################################################
alias pydl='pylauncher.py PythonBuildTools pydl.py'

################################################################################
# Clients
################################################################################
print_eval () { echo "$fg_no_bold[yellow]$@$reset_color"; $@ }

bucket   () { gp_bucketing $1 -cusips $2 -adt $(date +%m/%d/%Y) |& grep 'Sector Path' | awk '{ print $3 }' }
cdd      () { echo $(readlink -f "$1"); echo $(dirname $(readlink -f "$1")); cd $(dirname $(readlink -f "$1")) }
cnca     () { print_eval cnc $1 $2 -no_exp_mngd_pg -load_port_totals -load_pg_risk -load_port_risk -fund_level 10 -show_ticker -mid_level_funds -suppress_cash_no_short -suppress_cash -suppress_tot_assets -fund_htlink_dir . -index_htlink_dir . -reportDir $RPT_DIR -var_use_gp ${@[3,-1]} }
code     () { codeSearch.pl -o -c $@ }
fbom     () { iconv -f utf-16le -t utf-8 "$1" > "$1.tab" }
inw      () { cmd=$1; shift; while inotifywait -e close_write $@; do eval $cmd; done }
pmsa     () { print_eval pms $1 $2 -gpsettings GP:DAILY:i -pkg ADHOC -reportDir $RPT_DIR ${@[3,-1]} }
praaa    () { print_eval praada_nav.pl -port $1 -start_date $2 -end_date $3 -gpsettings GP -run_category DAILY -pkg_date $3 -force_nosave -rptdir $RPT_DIR ${@[4,-1]} }
ptd      () { perltidy $1 -o tidy.pm && vim -d $1 tidy.pm }
pwget    () { gpg --batch -q --decrypt $HOME/passwords.gpg | grep $1 | cut -d'|' -f4 | tr -d ' ' }
px_fund  () { gpsettings_params.pl -f $1 -p pms | grep -hoP '(?<=\-M )\w+' | xargs px_hi }
qs       () { $HOME/.quick_script/$1.pl ${@[2,-1]} }
vw       () { vim $(which $@) }
wiki     () { dig +short txt "$@".wp.dg.cx }

################################################################################
# Warp
################################################################################
getfile_override () { (( $+2 )) && print $2 || getfile $1 }
gptree () { cd "$Bfm/clients/$(getfile_override ClientAbbrev ${(U)1})/std/treeconfig/gp" }
pack   () { cd "$Bfm/clients/$(getfile_override ClientAbbrev ${(U)1})/std/GreenPkg" }

alias build='cd $(echo $PWD | sed -e "s#^$HOME/dev#/u1/build/dev#" -e "s#^$Bfm#/u1/build/dev#")'
alias home='cd $(echo $PWD | sed -e "s#^/u1/build/dev#$HOME/dev#" -e "s#^$Bfm#$HOME/dev#")'
alias prod='cd $(echo $PWD | sed -e "s#^$HOME/dev#$Bfm#" -e "s#^/u1/build/dev#$Bfm#")'

alias bins='cd /proj/space/binary'
alias ibins='cd /proj/space/binary/index'
alias ifiles="cd $Bfm/std/GreenPkg/ifiles/"
alias pesls="cd $Bfm/std/pesl"
alias rpt='cd /d0/prod1/reports'

################################################################################
# Aliases
################################################################################
alias b="$HOME/bin/smart_bump"
alias bc='BondCalc'
alias bf="$HOME/bin/smart_bump 9995"
alias bump='CalcController setpri -group 9995'
alias bust='/u1/build/dev/etc/bust'
alias c='quick_query cusip'
alias cc='CalcController'
alias cig='CalcController info group -name'
alias cp='cp -i'
alias curl="curl --proxy 'http://webproxy.bfm.com:8080'"
alias cvs='/usr/local/cvs/bin/cvs'
alias f='find . |& egrep'
alias gp='gpsettings_params.pl -p pms -f'
alias gpp=get_pkg_part
alias gpset=gpsettings_params.pl
alias gpgt=get_port_group_tree.pl
alias h='history'
alias hg='history | grep'
alias ht='history | tail'
alias ipl='perl5.8 -de 1'
alias killg='CalcController kill -group'
alias ld="find * -prune -type d"
alias mailme="history | tail -1 | cut -c 8- | mailx -s 'finished' $USER"
alias mv='mv -i'
alias noansi='sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g"'
alias nj='/usr/local/bfm/prod/nite_cs'
alias o='oasstat -all |& grep `whoami`'
alias org='/u1/bmckelve/bin/org_chart.pl'
alias pc='perlcritic'
alias pd="$HOME/bin/pardiff"
alias pump='CalcController postpone -group'
alias qq='quick_query'
alias resauce="source $HOME/.zshrc"
alias t='byobu attach -t multi-client'
alias tast='mkdir -p $RPT_DIR && cd $RPT_DIR'
alias u=urlify
alias update='/proj/pag/brymck/install'
alias w=$HOME/bin/oas_watch
alias v=vim
alias v=vimdiff
alias olog='cd /clients/$(getfile_override ClientAbbrev ${(U)1})/tmpint/oas/disbatch'
alias tolog='cd /tmpint/oas/batch/work/'
alias activate='source /u1/samrullo/pythonenv/bin/activate'
alias sm='python /u1/samrullo/pythonenv/script/sm.py -c'

################################################################################
# Global aliases
################################################################################
# Note: Global aliases can be used at any point in an expression
alias -g ...='cd ../..'
alias -g ....='cd ../../..'
alias -g .....='cd ../../../..'
alias -g BG='> /dev/null 2>&1 &'
alias -g GR='|& grep'
alias -g GU="| grep `whoami`"
alias -g H='-h |& grep'
alias -g HL='-h |& less'
alias -g L='|& less'
alias -g NE='2> /dev/null'
alias -g NUL='> /dev/null 2>&1'
alias -g V='|& vim -'

################################################################################
# Open file by extension
################################################################################
alias -s c=vim
alias -s cfg=vim
alias -s cpp=vim
alias -s h=vim
alias -s ifile=vim
alias -s log=vim
alias -s mb=vim
alias -s md=vim
alias -s pcl=vim
alias -s pesl=vim
alias -s snippets=vim
alias -s txt=vim
alias -s vim=vim

################################################################################
# Finishing up
################################################################################
autoload -U colors
autoload -U zcalc
autoload -U zmv

autoload -U compinit && compinit -u

################################################################################
# After hook
################################################################################
[ -f ~/.zshrc.after ] && source ~/.zshrc.after
export PATH="$HOME/.ruby/bin:$PATH"
export PATH="/opt/local/pkgs/ruby-1.8.7-p249/bin:$PATH"
export PATH="/opt/local/pkgs/rubygems-1.3.6/bin:$PATH"
export PATH="/opt/local/pkgs/rubygems-1.3.6/lib:$PATH"
export GEM_PATH="$HOME/.ruby:/u1/bmckelve/.ruby"

export PERL_MB_OPT="--install_base \"/u1/bmckelve/perl5\"";
export PERL_MM_OPT="INSTALL_BASE=/u1/bmckelve/perl5";
export PATH="$HOME/zsh/examples:$HOME/zsh/scripts:$PATH"
export PATH=/u1/samrullo/anaconda3/bin:$PATH
