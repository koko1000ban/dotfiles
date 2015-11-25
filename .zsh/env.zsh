#timezone
export TZ='Asia/Tokyo'
export LANG=ja_JP.UTF-8

PATH=$HOME/repos/bin:$PATH
PATH=$PATH:/usr/local/bin:/usr/local/sbin:/opt/local/bin:/opt/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin
PATH=$PATH:/usr/local/share/npm/bin
PATH=$PATH:/usr/local/heroku/bin

# for cabal
if [[ -d $HOME/.cabal/bin ]]; then
    PATH="$HOME/.cabal/bin:${PATH}"
fi

#DVM d_lang
if [[ -s "$HOME/.dvm/scripts/dvm" ]] ; then
    source "$HOME/.dvm/scripts/dvm"
else
    echo "see: https://bitbucket.org/doob/dvm/wiki/Home"
fi

#ARCHであれば、/opt以下のbinをPATHに追加
case `uname -a` in
  *ARCH*)
        echo "ArchLinux"
        # export JRUBY_OPTS="--ng"
        export JAVA_HOME=/opt/java

        #classpath
        export CLASSPATH=$HOME/repos/lang/java/lib:$CLASSPATH

        export SCALA_HOME=/usr/share/scala
        export GROOVY_HOME=/opt/groovy

        export ANDROID_SDK_HOME=$HOME/pkg/android-sdk-linux_x86
        export PATH=$ANDROID_SDK_HOME/tools:$PATH

         #fsc,scalaの起動最適化にgroovyserv使ってるので
         # yaourt -S groovy

        #pod2htmlとantなど
        export PATH=/usr/lib/perl5/core_perl/bin:/usr/bin/vendor_perl/:/usr/bin/core_perl:/usr/share/java/apache-ant/bin:$PATH

        #cpprefのドキュメントおくとこ
        #http://d.hatena.ne.jp/cou929_la/20091013/1255431781#
        export CPPREF_DOCROOT=$HOME/Dropbox/docs/cppref

        #ackとか
        export PATH=/usr/lib/perl5/vendor_perl/bin:$PATH

        #node.js
        export NODE_PATH=/home/tabi/.npm/libraries:$NODE_PATH
        export PATH=/home/tabi/.npm/bin:$PATH
        export MANPATH=/home/tabi/.npm/man:$MANPATH

        #googleappengine
        export PATH=$HOME/local/google_appengine:$PATH

        #actionscript
        export CLASSPATH=$HOME/.emacs.d/site-lisp/flyparse-mode/lib/flyparse-parsers.jar:$HOME/.emacs.d/site-lisp/flyparse-mode/lib/antlr-runtime-3.1.jar:$CLASSPATH

        #またつかうときに
        # #~/localにインストールしたやつ用
        # export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$HOME/local/lib
        # export C_INCLUDE_PATH=$C_INCLUDE_PATH:$HOME/local/include
        # export CPLUS_INCLUDE_PATH=$CPLUS_INCLUDE_PATH:$HOME/local/include

        ;;
    Darwin*)
        # export SCALA_HOME=/usr/local/Cellar/scala/2.8.0/
        # export GROOVY_HOME=/usr/local/Cellar/groovy/1.7.5/

        ;;
esac

#ruby rvm
# if [[ -s $HOME/.rvm/scripts/rvm ]] ; then
#     source $HOME/.rvm/scripts/rvm;
#     rvm use 1.9.3 --default
# else
#     echo "$ bash < <( curl http://rvm.beginrescueend.com/releases/rvm-install-head )"
# fi

#rbenv
if which rbenv > /dev/null; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)";
else
  echo "no rbenv...."
fi

# export PATH=$HOME/.rbenv/bin:$HOME/.phpenv/bin:$PATH
# eval "$(phpenv init -)"

# #python
# if [[ -s $HOME/.pythonbrew/etc/bashrc ]] ; then
#     source $HOME/.pythonbrew/etc/bashrc;
# else
#     echo "pythonbrew not installed. see https://github.com/utahta/pythonbrew."
# fi

#play1.1ライブラリあればそのディレクトリを入れる
# if [[ -s /opt/play-1.1/play ]] ; then export PATH=/opt/play-1.1:$PATH ; fi
#export PATH=$PATH


#gauche
GAUCHE_LOAD_PATH=.:..:./lib:$HOME/repos/lang/gauche/lib
export GAUCHE_LOAD_PATH=$GAUCHE_LOAD_PATH


# python
if [[ -d "$HOME/.virtualenvs" ]] ; then
   export WORKON_HOME=$HOME/.virtualenvs
   export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python
   source /usr/local/bin/virtualenvwrapper.sh
else
   echo "no virtualenv .."
fi

##########
# perl
##########
#perlbrew系
# if [ -e $HOME/perl5/perlbrew/etc/bashrc ]; then
#     echo "perlbrew load success"
#     source $HOME/perl5/perlbrew/etc/bashrc
# else
#     echo "no perlbrew, see http://webtech-walker.com/archive/2010/04/22173415.html"
# fi
# PERL5LIB=.:./lib:$HOME/repos/lang/perl/lib:/usr/local/lib/perl:/usr/local/lib/perl/5.8.8/site_perl:/usr/local/lib/perl/5.10.1/site_perl:$PERL5LIB
# export PERL5LIB=$PERL5LIB
# if [ -
#  $HOME/perl5 ]; then
#     echo "local perl5 dir found. env set..."
#     PERL5LIB=$HOME/perl5/lib/perl5/x86_64-linux-thread-multi:$HOME/perl5/lib/perl5
#     export PERL5LIB=$PERL5LIB
#     export PERL_CPANM_OPT="--local-lib=~/perl5"
#     export PATH=$HOME/perl5/bin:$PATH
# fi

export EDITOR=subl
export PAGER=less
export MANPATH=~/local/man:/opt/local/man:/opt/local/share/man:/usr/local/share/man:/usr/share/man:$MANPATH

case `uname` in
Darwin)
    echo "env Darwin"

    #mysql
    export PATH=/usr/local/mysql/bin:$PATH

    #home-local
    HOME_LOCAL_HOME=$HOME/local

    # this cause load error with rvm
    # export C_INCLUDE_PATH=$C_INCLUDE_PATH:$HOME_LOCAL_HOME/include
    # export CPLUS_INCLUDE_PATH=$C_INCLUDE_PATH

    # export DYLD_FALLBACK_LIBRARY_PATH=/usr/local/mysql/lib:$HOME/lib:$HOME_LOCAL_HOME/lib:/usr/local/lib:/lib:/usr/lib
    # export DYLD_FALLBACK_FRAMEWORK_PATH=$DYLD_FALLBACK_FRAMEWORK_PATH:$HOME_LOCAL_HOME/Library/Frameworks

    # #haskell
    # export PATH="$HOME/Library/Haskell/bin:$PATH"

    #golang
    # export GOROOT=$HOME/repos/denv/go
    # export GOARCH=amd64
    # export GOOS=darwin
    # export GOPATH=$HOME/Dropbox/repos/workspace/life_game
    # export PATH=$GOROOT/bin:$PATH
    export GOPATH=$HOME/repos/lang/golang/lib
    export PATH=$PATH:$GOPATH/bin

    ## homebrew iru??
    export DYLD_LIBRARY_PATH=$DYLD_LIBRARY_PATH:/usr/local/lib:$HOME/local/lib
    export DYLD_FALLBACK_LIBRARY_PATH=$DYLD_LIBRARY_PATH
    export LIBRARY_PATH=$LIBRARY_PATH:/opt/boxen/homebrew/lib/

    export TMPDIR=/tmp

    # export JAVA_HOME=/System/Library/Frameworks/JavaVM.framework/Versions/CurrentJDK/Home
    export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.7.0_17.jdk/Contents/Home

    LUAROCKS_CONFIG=$HOME/repos/lang/lua/rocks_config.lua
    export LUAROCKS_CONFIG

    #export LUA_PATH="/opt/boxen/homebrew/share/lua/5.1/?.lua;/opt/boxen/homebrew/Cellar/lua/5.1.5/lib/?.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/share/lua/5.1/?.lua;;"
    export LUA_PATH="/opt/boxen/homebrew/share/lua/5.1/luarocks/share/lua/5.1/?.lua;/opt/boxen/homebrew/share/lua/5.1/luarocks/share/lua/5.1/?/init.lua;/opt/boxen/homebrew/share/lua/5.1/?.lua;/opt/boxen/homebrew/Cellar/lua/5.1.5/lib/?.lua;$HOME/repos/lang/lua/lib/?.lua;/usr/local/lib/lua/5.1/?.lua;/usr/local/share/lua/5.1/?.lua;./?.lua;/usr/local/share/lua/5.1/?/init.lua;/usr/local/lib/lua/5.1/?/init.lua;;"
    export LUA_CPATH='/opt/boxen/homebrew/share/lua/5.1/luarocks/lib/lua/5.1/?.so;./?.so;/usr/local/lib/lua/5.1/?.so;/usr/local/lib/lua/5.1/loadall.so'
    export PATH="/opt/boxen/homebrew/share/lua/5.1/luarocks/bin/:$PATH"

    # pbcopyで日本語(UTF-8)がコピーできるようになる
    #__CF_USER_TEXT_ENCODING=0x1F5:1:14    # 元の値
    __CF_USER_TEXT_ENCODING=0x1F5:0x8000100:14
    export __CF_USER_TEXT_ENCODING

    #alias
    alias emacs="open -a Emacs"
    alias firefox="open -a Firefox"
    alias preview="open -a Preview"
    alias safari="open -a Safari"

    #gitで警告出るので
    export LC_CTYPE="ja_JP.UTF-8"
    export LC_ALL="ja_JP.UTF-8"

    keychain ~/.ssh/id_rsa
    source ~/.keychain/$HOST-sh

    # if [[ -s "~/.MacOSX/environment.plist" ]] ; then
    #     echo "environment.plist found. so update plist"
    #     /Applications/Emacs.app/Contents/MacOS/Emacs --batch -l ~/repos/misc/envionment-support.el -f generate-environment
    # else
    #     echo "mkdir .MacOSX; touch .MacOSX/environment.plist";
    # fi
;;
Linux)
    echo "env linux"
    if [ -f "/usr/GNUstep/System/Library/Makefiles/GNUstep.sh" ]; then
        echo "GNUstep config found! so, load gnustep"
        export PATH=$PATH:/home/tabi/pkg/llvm/Debug/bin

        echo "if wanna build under clang, exec 'export CC=clang'"
        # export CC='clang'
        source /usr/GNUstep/System/Library/Makefiles/GNUstep.sh
    fi
;;
esac

#for work
set_work(){
    echo "work env loaded.."
}

#for home
set_home(){
    echo "home env loaded.."
}

ping -t 1 -c 1 172.17.0.0 >& /dev/null && set_work || set_home

if [ $MY_SHOW_ENV ]; then
    env
fi
