source /usr/local/std/.login
stty erase '^h'
stty echoe
setenv MORE '-c'
if ( -f /bin/zsh ) exec /bin/zsh
linux.pl

# Xterm Safety settings - May 2019
if (-f /usr/local/std/Xterm_Safety/.login) then
     source /usr/local/std/Xterm_Safety/.login
endif
