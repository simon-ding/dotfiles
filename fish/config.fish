#######
######### fasd ###########################################
if type -q fasd
  # Hook into fish preexec event
  function __fasd_run -e fish_preexec
    if type -q disown
      command fasd --proc (command fasd --sanitize "$argv" | tr -s ' ' \n) > "/dev/null" 2>&1 &; disown
    else
      command fasd --proc (command fasd --sanitize "$argv" | tr -s ' ' \n) > "/dev/null" 2>&1 &
    end
  end
else
  echo "🍒  Please install 'fasd' first!"
end

#function fasd_cd -d "fasd builtin cd"
#  if test (count $argv) -le 1
#    command fasd "$argv"
#  else
#    set -l ret (command fasd -e 'printf %s' $argv)
#    test -z "$ret"; and return
#    test -d "$ret"; and cd "$ret"; or printf "%s\n" $ret
#  end
#end
#alias v="fasd -e vim"
#alias o='a -e xdg-open'
#alias j='fasd_cd -i'
###########################################################


############## GNU Utilities ###############
#
#set _core_utils 'b2sum' 'base32' 'base64' 'basename' 'cat' 'chcon' 'chgrp' 'chmod' 'chown' \
#            'chroot' 'cksum' 'comm' 'cp' 'csplit' 'cut' 'date' 'dd' 'df' \
#            'dir' 'dircolors' 'dirname' 'du' 'env' 'expand' 'expr' \
#            'factor' 'false' 'fmt' 'fold' 'groups' 'head' 'hostid' 'id' \
#            'install' 'join' 'kill' 'link' 'ln' 'logname' 'ls' 'md5sum' 'mkdir' \
#            'mkfifo' 'mknod' 'mktemp' 'mv' 'nice' 'nl' 'nohup' 'nproc' \
#            'numfmt' 'od' 'paste' 'pathchk' 'pinky' 'pr' 'printenv' 'printf' 'ptx' \
#            'pwd' 'readlink' 'realpath' 'rm' 'rmdir' 'runcon' 'seq' 'sha1sum' \
#            'sha224sum' 'sha256sum' 'sha384sum' 'sha512sum' 'shred' 'shuf' \
#            'sleep' 'sort' 'split' 'stat' 'stdbuf' 'stty' 'sum' 'sync' 'tac' 'tail' \
#            'tee' 'timeout' 'touch' 'tr' 'true' 'truncate' 'tsort' \
#            'tty' 'uname' 'unexpand' 'uniq' 'unlink' 'uptime' 'users' 'vdir' \
#            'wc' 'who' 'whoami' 'yes'
#set _find_utils 'find' 'locate' 'oldfind' 'updatedb' 'xargs'
#set _miscellaneous_cmds 'getopt' 'grep' 'indent' 'make' 'sed' 'tar' 'time' 'units' 'which'
#
#set _gnu_utility_cmds $_core_utils $_find_utils $_miscellaneous_cmds
#for _gnu_cmd in $_gnu_utility_cmds
#    set _gnu_gcmd  g$_gnu_cmd
#    if type -q $_gnu_gcmd
#        #eval "
#        #function $_gnu_cmd
#        #    command -sq $_gnu_gcmd \$argv
#        #end"
#        eval "alias $_gnu_cmd='$_gnu_gcmd'"
#    end
#    set -e _gnu_gcmd
#end
#alias ls="gls --color=auto"
#alias grep='ggrep --color=auto'
#set -e _core_utils
#set -e _find_utils
#set -e _miscellaneous_cmds
#set -e _gnu_utility_cmds
#
###### miscellaneous ########
set -x EDITOR vim
#disable greeting
set fish_greeting


#######################
#  coloring manpages  #
#######################

set -x LESS_TERMCAP_mb \e'[01;31m'       # begin blinking
set -x LESS_TERMCAP_md \e'[01;38;5;74m'  # begin bold
set -x LESS_TERMCAP_me \e'[0m'           # end mode
set -x LESS_TERMCAP_se \e'[0m'           # end standout-mode
set -x LESS_TERMCAP_so \e'[38;5;246m'    # begin standout-mode - info box
set -x LESS_TERMCAP_ue \e'[0m'           # end underline
set -x LESS_TERMCAP_us \e'[04;38;5;146m' # begin underline

######### the fuck #########
function fuck -d "Correct your previous console command"
  set -l fucked_up_command $history[1]
  env TF_SHELL=fish TF_ALIAS=fuck PYTHONIOENCODING=utf-8 thefuck $fucked_up_command | read -l unfucked_command
  if [ "$unfucked_command" != "" ]
    eval $unfucked_command
    builtin history delete --exact --case-sensitive -- $fucked_up_command
    builtin history merge ^ /dev/null
  end
end

########### functions ############
function subl --description 'Open Sublime Text'
  if test -d "/Applications/Sublime Text.app"
    "/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl" $argv
  else if test -d "/Applications/Sublime Text 2.app"
    "/Applications/Sublime Text 2.app/Contents/SharedSupport/bin/subl" $argv
  else if test -x "/opt/sublime_text/sublime_text"
    "/opt/sublime_text/sublime_text" $argv
  else if test -x "/opt/sublime_text_3/sublime_text"
    "/opt/sublime_text_3/sublime_text" $argv
  else
    echo "No Sublime Text installation found"
  end
end


############# osx ###################################
function cdf --description 'Change to directory opened by Finder'
	if [ -x /usr/bin/osascript ]
    set -l target (osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)')
    if [ "$target" != "" ]
      cd "$target"; pwd
    else
      echo 'No Finder window found' >&2
    end
  end
end

function ql -d "Quick Look a specified file or directory"
  if [ (count $argv) -gt 0 ]
    qlmanage >/dev/null 2> /dev/null -p $argv &
  else
    echo "No arguments given"
  end
end

######## homebrew ############
alias brew_update='brew -v update && brew outdated && brew upgrade && brew cleanup'
alias cask_update='brew update && brew cask reinstall (brew cask outdated) && brew cleanup'
alias cask='brew cask'


############# paths #########
set --export PATH $PATH ~/go/bin


######### aliases #########
alias sed='gsed'
alias awk='gawk'
alias ls="gls --color=auto"
alias grep='ggrep --color=auto'
alias cp='gcp'
alias x='unar'
alias cf='cd ~/.config/fish/'
alias dlc_cache='curl -H "Authorization: Bearer eyJhbGciOiJIUzUxMiJ9.eyJzdWIiOiJhZG1pbiIsImF1dGgiOiJST0xFX0FETUlOLFJPTEVfVVNFUiJ9.l_oraG1eECclIcPZuAOfBK4cnXgpLrkh6Zbn3ibUAx7BUIspzmSYkJ5hrHo2U_RAnqfjaSk_U2po7AFy2aOiKg"  http://localhost:8080/ops/reload/api-tags'

