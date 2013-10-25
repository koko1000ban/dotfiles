bindkey -e

for file in env options antigen complete func git history ulimit alias; do
    echo "$file.zsh load start..."

    [ -f ~/.zsh/$file.zsh ]; source ~/.zsh/$file.zsh

    echo "$file.zsh load end"
done

#keybind
#Deleteキーで〜出ちゃうのを回避
bindkey "^?"    backward-delete-char
bindkey "^H"    backward-delete-char
bindkey "^[[3~" delete-char
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line

REPORTTIME=3

#tmp
if ! [ -d ~/tmp/ ]; then
    command /bin/mkdir ~/tmp
fi

#backup
if ! [ -d ~/.backup/ ]; then
    command /bin/mkdir ~/.backup
fi

#stderr
function redrev() {
   perl -pe 's/^/\e[41m/ && s/$/\e[m/';
}
alias -g RED='2> >(redrev)'

#コマンド入力中に入力中のファイルを閲覧
#http://dev.ariel-networks.com/Members/matsuyama/zsh-peek-file
function view-file() {
    zle -I
    local file
    local -a words

    words=(${(z)LBUFFER})
    file="${words[$#words]}"
    [[ -f "$file" ]] && $PAGER "$file"
}
zle -N view-file
bindkey "^x^r" view-file

#直前にうったコマンドをクリップボードへ
copy-prev-cmd-to-clipboard () {
    ZHIST='.zsh_history'
    cat ~/$ZHIST | tail -n 1 | perl -e '$h = <STDIN>; $h =~ m/;(.+)/; print $1;' | pbcopy
}
zle -N copy-prev-cmd-to-clipboard
bindkey '^K' copy-prev-cmd-to-clipboard

function e()
{
    #emacsclient -n ${*:-.} 2>/dev/null  || emacs ${*:-.} 2>/dev/null || open -a /Applications/Emacs.app ${*:-.}
    emacsclient -n ${*:-.} 2>/dev/null
}

# SSHコマンドはscreenの新しい窓で
function ssh_screen(){
    eval server=\${$#}
    screen -t $server ssh "$@"
}

#for tmux
#[ -n "`pgrep tmux`" ] && tmux attach || tmux

#if [ $SHLVL = 1 ]; then
#    alias tmux="tmux attach || tmux new-session \; source-file ~/.tmux/session"
#fi

[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator

P_PROC=`ps aux | grep $PPID | grep sshd | awk '{ print $11 }'`
if [ "$P_PROC" = sshd: ]; then
    script ~/log/`date +%Y%m%d-%H%M%S.log`
    exit
fi

[[ $EMACS = t ]] && unsetopt zle
source /usr/local/etc/profile.d/z.sh
