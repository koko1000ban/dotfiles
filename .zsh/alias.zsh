#########
# alias
#########
#alias svn='colorsvn'
# alias ls='ls --color=always'
# alias ls='ls -G'
alias l='ls -F'
# alias ll='ls -la -F | less -R'
alias ll='ls -la --color=auto'
alias rr='mv -f --backup=numbered --target-directory /tmp'

#alias rm='rm -riv'
# alias g='grep'
#g はもはやgitのことです
alias g="git"
alias x='xargs'
alias f='find'
alias -g T="|tail"

alias bn="bundle"

alias g++0x="g++ -std=c++0x -Wall -Wextra"

alias dirsizeall="du -hx --max-depth=1 | sort -t 1 -n"

#alias emacs="emacsclient -a emacs"

#2009.09.13
#colorful man
#ttp://d.hatena.ne.jp/edvakf/20090912/1252760527
# .terminfoが必要
alias man="TERMINFO=~/.terminfo/ LESS=C TERM=mostlike PAGER=less man"

alias cpan-installed='find `perl -e "print \"@INC\""` -name "*.pm" -print'
alias cpan-uninstall='perl -MExtUtils::Install -MExtUtils::Installed -e "unshift@ARGV,new ExtUtils::Installed;sub a{\@ARGV};uninstall((eval{a->[0]->packlist(a->[1])}||do{require CPAN;a->[0]->packlist(CPAN::Shell->expandany(a->[1])->distribution->base_id=~m/(.*)-[^-]+$/)})->packlist_file,1,a->[2])"'

#haskell
alias hasktags-r="find . -type f -name '*.hs' -print0 | xargs -0 hasktags -c"

# Disable autocorrect
alias bundle='nocorrect bundle'

case `uname` in
Linux)
    alias trash='mv -f --backup=numbered --target-directory ~/.local/share/Trash/files'

    #alias gem=gem1.8
    #alias terminal=gnome-terminal

    #alias emacs='emacs-snapshot-gtk'

    alias open="xdg-open"

    alias -g CP='| xsel -b'

    #copy pbcopy
    alias pbcopy="xclip -selection clipboard"
    alias pbpaste="xclip -selection clipboard -o"
    alias C="pbcopy"
    alias time=/usr/bin/time
    alias yaourt_update="yaourt -Syu --devel --aur"
;;
Darwin)

   # sourceTree
    alias st='open -a SourceTree `git rev-parse --show-toplevel`'
    # alias emacsclient="/Applications/Emacs.app/Contents/MacOS/bin/emacsclient"

    alias -g CP='| pbcopy'

    alias ctags='/usr/local/Cellar/ctags/5.8/bin/ctags'

    # alias ruby=/usr/bin/ruby
    #cpan
    alias sudo-cpan='sudo -H cpan'

    #move where finder exists
    alias fcd='source /usr/local/bin/fcd.sh'

    alias tailf='tail -f'
    #crontab
    #http://ido.nu/kuma/2006/01/31/crontab-warns-temp-file-must-be-edited-in-place/
    alias crontab="EDITOR=\"$HOME/bin/vi\" crontab"

    # alias emacsclient=/Applications/Emacs.app/Contents/MacOS/bin/emacsclient
    #emacs
    #alias emacs='/Applications/Emacs.app/Contents/MacOS/Emacs'

    #vim
    alias gvim='/Applications/MacVim.app/Contents/MacOS/MacVim'

    #textmate
    alias textmate='/Applications/TextMate.app/Contents/MacOS/TextMate'

    #synergys
    alias synergys-start='cd /Applications/synergy-1.3.1/;./synergys -f -c synergy.conf --debug DEBUG'

    #coreutils
    alias base64=gbase64
    #alias basename=gbasename
    alias cat=gcat
    alias chgrp=gchgrp
    alias chmod=gchmod
    alias chown=gchown
    alias chroot=gchroot
    alias cksum=gcksum
    alias comm=gcomm
    alias cp=gcp
    alias csplit=gcsplit
    alias cut=gcut
    alias date=gdate
    alias dd=gdd
    alias df=gdf
    alias dir=gdir
    alias dircolors=gdircolors
    alias dirname=gdirname
    alias du=gdu
    # alias echo=gecho
    alias env=genv
    alias expand=gexpand
    alias expr=gexpr
    alias factor=gfactor
    alias false=gfalse
    alias fmt=gfmt
    alias fold=gfold
    alias groups=ggroups
    alias head=ghead
    alias hostid=ghostid
    #alias hostname=ghostname
    alias id=gid
    alias install=ginstall
    alias join=gjoin
    alias kill=gkill
    alias link=glink
    alias ln=gln
    alias logname=glogname
    # alias ls='gls -F --color=auto'
    alias ls=gls
    alias ll='gls -la -F --color=auto'

    alias md5sum=gmd5sum
    alias mkdir=gmkdir
    alias mkfifo=gmkfifo
    alias mknod=gmknod
    alias mv=gmv
    alias nice=gnice
    alias nl=gnl
    alias nohup=gnohup
    alias od=god

    alias paste=gpaste
    alias pathchk=gpathchk
    alias pinky=gpinky
    alias pr=gpr
    alias printenv=gprintenv
    alias printf=gprintf
    alias ptx=gptx
    alias pwd=gpwd
    alias readlink=greadlink
    alias rm=grm
    alias rmdir=grmdir
    alias seq=gseq
    alias sha1sum=gsha1sum
    alias sha224sum=gsha224sum
    alias sha256sum=gsha256sum
    alias sha384sum=gsha384sum
    alias sha512sum=gsha512sum
    alias shred=gshred
    alias shuf=gshuf
    alias sleep=gsleep
    alias sort=gsort
    alias split=gsplit
    alias stat=gstat
    alias stty=gstty
    #alias su=gsu
    alias sum=gsum
    alias sync=gsync
    alias tac=gtac
    alias tail=gtail
    alias tee=gtee
    alias test=gtest
    alias touch=gtouch
    alias tar=gnutar
    alias tr=gtr
    alias true=gtrue
    alias tsort=gtsort
    alias tty=gtty
    alias uname=guname
    alias unexpand=gunexpand
    alias uniq=guniq
    alias unlink=gunlink
    alias uptime=guptime
    alias users=gusers
    alias vdir=gvdir
    alias wc=gwc
    alias who=gwho
    alias whoami=gwhoami
    alias yes=gyes
;;
esac


