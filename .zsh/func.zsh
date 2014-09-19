function psx {
    ps aux | head -1 && ps aux | grep $1 | sed -e '/grep/d'
};

# function cd {
#   builtin cd $@ && ls -v -F --color=auto
# };

function my-repos-update {


};

#rubygemsのとこに移動
function cdgem() {
  cd `echo $GEM_HOME/**/gems/$1*|awk -F' ' '{print $1}'`
}

compctl -K _cdgem cdgem
function _cdgem() {
  reply=(`find $GEM_HOME -type d|grep -e '/gems/[^/]\+$'|xargs -I{} basename {}|sort -nr`)
}


#辞書
#http://webtech-walker.com/archive/2009/10/06093250.html
function alc() {
  if [ $# != 0 ]; then
    w3m "http://eow.alc.co.jp/$*/UTF-8/?ref=sa"
  else
    echo 'usage: alc word'
  fi
}

#gitrootまで戻る
function u()
{
    cd ./$(git rev-parse --show-cdup)
    if [ $# = 1 ]; then
        cd $1
    fi
}

#上に戻る
function up()
{
    to=$(perl -le '$p=$ENV{PWD}."/";$d="/".$ARGV[0]."/";$r=rindex($p,$d);$r>=0 && print substr($p, 0, $r+length($d))' $1)
    if [ "$to" = "" ]; then
        echo "no such file or directory: $1" 1>&2
        return 1
    fi
    cd $to
}

#########
# color make
#########

e_normal=`echo -e "\033[0;30m"`
e_RED=`echo -e "\033[1;31m"`
e_BLUE=`echo -e "\033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command ./waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}

#bundlerのディレクトリにcd
function cd_bundle() {
  cd `ruby -e "require 'rubygems';gem 'bundler';require 'bundler';Bundler.load.specs.each{|s| puts s.full_gem_path if s.name == '${1}'}"`
}

extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
	  *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.lzma)      lzma -dv $1    ;;
          *.xz)        xz -dv $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

alias ex='extract'

##color
#http://d.hatena.ne.jp/tkng/20100712/1278896396
e_normal=`echo -e "\033[0;30m"`
e_RED=`echo -e "\033[1;31m"`
e_BLUE=`echo -e "\033[1;36m"`

function make() {
    LANG=C command make "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}
function cwaf() {
    LANG=C command waf "$@" 2>&1 | sed -e "s@[Ee]rror:.*@$e_RED&$e_normal@g" -e "s@cannot\sfind.*@$e_RED&$e_normal@g" -e "s@[Ww]arning:.*@$e_BLUE&$e_normal@g"
}


function contextual_rake() {
    # $* joins args with : if not specified
    oldifs=$IFS
    IFS=' '
    if [ -e .zeus.sock ]; then
        zeus rake $*
    elif [ -f Gemfile ]; then
        bundle exec rake $*
    else
        \rake $*
    fi
    IFS=$oldifs
}
alias rk=contextual_rake

#########
# percol utils
##########

# inspired http://qiita.com/hfm/items/ad1641225991d56373d2
function gh-browse-rev() {
  git log --format="%ai  %an  %h  %d %s" | percol | awk 'match($0,/[[:blank:]]{2}[a-z0-9]{7}[[:blank:]]{2}/)  { print substr($0, RSTART, RLENGTH) }' | xargs echo -n | xargs -I{} gh browse commit/{}
}

function percol_select_directory() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    local dest=$(_z -r 2>&1 | eval $tac | percol --query "$LBUFFER" | awk '{ print $2 }')
    if [ -n "${dest}" ]; then
        cd ${dest}
    fi
    zle reset-prompt
}
zle -N percol_select_directory
bindkey "^X^J" percol_select_directory

# process kill
function peco-pkill() {
  for pid in `ps aux | percol | awk '{ print $2 }'`
  do
    kill $pid
    echo "Killed ${pid}"
  done
}
zle -N peco-pkill
bindkey "^X^K" peco-pkill

alias pk="peco-pkill"