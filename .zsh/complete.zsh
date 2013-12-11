#パス補完高速化??
#http://memo.officebrook.net/20101117.html#p01
zstyle ':completion:*' accept-exact '*(N)'

#color
eval `dircolors ~/.zsh/.dircolors`
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

#ignore case when completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' menu select=1
zstyle ':completion:*:cd:*' tag-order local-directories path-directories

#scp時の補完無効
zstyle ':completion:*:complete:scp:*:files' command command -

#プロセス補完case
zstyle ':completion:*:processes' command 'ps x -o pid,s,args'

#completion development
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*' group-name ''

#haskell 4cabal
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*:approximate:*' max-errors 1 numeric


#completion
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)
fpath=($HOME/.zsh/completion $fpath)

echo $fpath

autoload -U $HOME/.zsh/completion/*(:t)
autoload -U compinit
compinit -u

zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin \
    /usr/sbin /usr/bin /sbin /bin /usr/X11R6/bin \
    /usr/local/git/bin

source ~/.zsh/completion/cdd

#zsh-completions
fpath=(~/.zsh/zsh-completions/src $fpath)

# #2010.03.26 pythonなにそれ状態なので削除
# #python pip
# eval `pip completion --zsh`


#2010.03.29 ^Zが殺されてうまくキーが使えないので
#変態 - 先方予測
# autoload predict-on
# zle -N predict-on
# zle -N predict-off
# bindkey '^X^Z' predict-on
# bindkey '^Z' predict-off
# zstyle ':predict' verbose true

generate-complete-function/ruby/optparse () {
  ruby -r $HOME/bin/zshcomplete $1 > $HOME/.zsh/completion/_`basename $1`
  reload-complete-functions
}

reload-complete-functions() {
  local f
  f=($HOME/.zsh/completion/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t

  f=($HOME/.zsh/func/*(.))
  unfunction $f:t 2> /dev/null
  autoload -U $f:t
}

#2012.06.15 it has error
# #gem completion
# alias gem-update-list="gem list -r 2> /dev/null | grep '^[a-zA-Z]' | awk '{print \$1}' > $HOME/.gemlist"
# _gem () {
#     LIMIT=`date -d "1 week ago" +%s`
#     if ! [[ ( -f $HOME/.gemlist ) && ( `date -r "$HOME/.gemlist" +%s` -gt $LIMIT ) ]]; then
#         gem-update-list
#     fi
#     reply=(`cat $HOME/.gemlist`)
# }
# compctl -k "(`gem help commands | grep '^    \w.*' | sed 's/^\s*//' | sed 's/\s\s*.*//'`)" -x 'c[-1,-t]' - 'C[-1,(install)]' -K _gem -- gem

#script/generate completion
_generate () {
    if [ ! -f .generators ]; then
    ./script/generate --help | grep '^  [^ ]*: ' | sed 's/[^:]*:/compadd/' | sed 's/\,//g' > .generators
    fi
    `cat .generators`
}
compdef _generate generate
compdef _generate destroy

#スクリーン上から補完する
HARDCOPYFILE=$HOME/tmp/screen-hardcopy
touch $HARDCOPYFILE

dabbrev-complete(){
    local reply lines=80
    screen -X eval "hardcopy -h $HARDCOPYFILE"
    reply=($(sed '/^$/d' $HARDCOPYFILE | sed '$ d' | tail -$lines))
    compadd - "${reply[@]%[*/=@|]}"
}

zle -C dabbrev-complete menu-complete dabbrev-complete
bindkey '^o' dabbrev-complete
bindkey '^o^_' reverse-menu-complete

#シングルクウォートとかで囲む
autoload -U modify-current-argument
# シングルクォート用
_quote-previous-word-in-single() {
    modify-current-argument '${(qq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-single
bindkey '^[s' _quote-previous-word-in-single

# ダブルクォート用
_quote-previous-word-in-double() {
    modify-current-argument '${(qqq)${(Q)ARG}}'
    zle vi-forward-blank-word
}
zle -N _quote-previous-word-in-double
bindkey '^[d' _quote-previous-word-in-double

#rake補完
# http://weblog.rubyonrails.org/2006/03/09/fast-rake-task-completion-for-zsh/
# http://rubyist.g.hatena.ne.jp/znz/20060617/p1
_rake_does_task_list_need_generating () {
  if [[ ! -f .rake_tasks ]]; then return 0;
  else
    return $([[ Rakefile -nt .rake_tasks ]])
  fi
}

_rake () {
  if [[ -f Rakefile ]]; then
    if _rake_does_task_list_need_generating; then
      echo "\nGenerating .rake_tasks..." >&2
      rake --silent --tasks | cut -d " " -f 2 >| .rake_tasks
    fi
    compadd $(<.rake_tasks)
  fi
}
compdef _rake rake

# autoload bashcompinit
# bashcompinit
#source ~/.zsh/completion/git-completion.bash
source ~/.zsh/completion/_cmake_wrap
source ~/.zsh/completion/git-now-completion.zsh
