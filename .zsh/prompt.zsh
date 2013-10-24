echo "prompt setting..."
case ${UID} in
0)
        echo " in root."
        #root
        PROMPT="%B%{^[[31m%}%/#%{^[[m%}%b "
        PROMPT2="%B%{^[[31m%}%_#%{^[[m%}%b "
        SPROMPT="%B%{^[[31m%}%r is correct? [n,y,a,e]:%{^[[m%}%b "
        [ -n "${REMOTEHOST}${SSH_CONNECTION}" ] &&
        # PROMPT="%{^[[37m%}${HOST%%.*} ${PROMPT}"
        ;;
*)
        echo " in normal user."

        #normal user
        local GRAY=$'%{\e[1;30m%}'
        local LIGHT_GRAY=$'%{\e[0;37m%}'
        local WHITE=$'%{\e[1;37m%}'
        local LIGHT_BLUE=$'%{\e[1;36m%}'
        local YELLOW=$'%{\e[1;33m%}'
        local PURPLE=$'%{\e[1;35m%}'
        local GREEN=$'%{\e[1;32m%}'
        local BLUE=$'%{\e[1;34m%}'

        autoload -Uz add-zsh-hook
        autoload -U colors
        colors

        autoload -Uz vcs_info
        zstyle ':vcs_info:*' enable git svn hg bzr
        zstyle ':vcs_info:*' formats '%{'${fg[red]}'%}[%s %b] %{'$reset_color'%}'
        zstyle ':vcs_info:*' actionformats '%{'${fg[red]}'%}[%s %b] %{'$reset_color'%}'

        autoload -Uz is-at-least
        if is-at-least 4.3.10; then
  # この check-for-changes が今回の設定するところ
            zstyle ':vcs_info:git:*' check-for-changes true
            zstyle ':vcs_info:git:*' stagedstr "S"    # 適当な文字列に変更する
            zstyle ':vcs_info:git:*' unstagedstr "U"  # 適当の文字列に変更する
            zstyle ':vcs_info:git:*' formats '%{'${fg[red]}'%}[%s %b %c%u] %{'$reset_color'%}' #%c%uがstage, unstage
            zstyle ':vcs_info:git:*' actionformats '%{'${fg[red]}'%}[%s %b|%a %c%u] %{'$reset_color'%}'
            zstyle ':vcs_info:git:*' use-simple true
        fi

        # # local _pre=""
        # # function __store_pre_cmd(){
        # #     _pre="$1"
        # # }
        # # add-zsh-hook preexec __store_pre_cmd

        # function _update_vcs_info_msg() {
        #     psvar=()
        #     LANG=en_US.UTF-8 vcs_info
        #     [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        # }
        # add-zsh-hook precmd _update_vcs_info_msg

        # #重いためpreexecでvcs_info更新をする
        # function _update_vcs_info_msg() {
        #     case "$1" in
        #         cd*|git*|svn*|hg*|bzr*)
        #             echo "zsh: update vcs_info"
        #             psvar=()
        #             LANG=en_US.UTF-8 vcs_info
        #             [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
        #             ;;
        #     esac
        # }
        # add-zsh-hook preexec _update_vcs_info_msg

        local _pre=''
        __store_pre_cmd() {
            # echo "preexecccc"
            _pre="$1"
        }
        add-zsh-hook preexec __store_pre_cmd

        __update_vcs_info() {
            # echo "precmmddddd"
            _r=$?
            case "${_pre}" in
                cd*|git*|svn*|hg*|bzr*)
                    psvar=()
                    _pre=''
                    LANG=en_US.UTF-8 vcs_info
                    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
                    ;;
            esac
            return ${_r}
        }

        #precmd
        . `brew --prefix`/etc/profile.d/z.sh
        function precmd () {
            _z --add "$(pwd -P)"
            # __update_vcs_info
        }
        # add-zsh-hook precmd __update_vcs_info

        function rbenv_version() {
          echo -n "${$(rbenv version)%% *}"
        }

        setopt prompt_subst
        LANG=en_US.UTF-8 vcs_info

        LOADAVG=''

        # # RPROMPT='%F{yellow}[r:`~/.rvm/bin/rvm-prompt`]%f'
        # SPROMPT="%r is correct? [n,y,a,e]: "
        # PROMPT="%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/!(;_;%)?) %B%~$%b%{${reset_color}%} "
        # PROMPT="%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/!(;_;%)?)${reset_color}${vcs_info_msg_0_}%{${fg[yellow]}%}%~%%%{$reset_color%} "

        setopt correct
        # PROMPT=$'${vcs_info_msg_0_}%{${fg[yellow]}%}%~%%%{$reset_color%}\n '
        # PROMPT2="%{$bg[blue]%}%_>%{$reset_color%}%b "
        # SPROMPT="%{$bg[red]%}%{$suggest%}(._.%)? %B %r is correct? [n,y,a,e]:%{${reset_color}%}%b "
        # RPROMPT='%F{yellow}@${HOST%%.*}[r:`rbenv version | sed -e "s/ .*//"`]%f%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/h-i!(;_;%)..?)%{$reset_color%}'
        # PROMPT=$'${vcs_info_msg_0_}%{${fg[yellow]}%}%~ %F{yellow}@${HOST%%.*}[r:`rbenv version | sed -e "s/ .*//"`]%f\n%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/h-i!(;_;%)..?)%{$reset_color%}%% '
        # PROMPT=$'${vcs_info_msg_0_}%{${fg[yellow]}%}%~ %F{yellow}@${HOST%%.*}[r:`~/.rvm/bin/rvm-prompt`]%f\n%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/h-i!(;_;%)..?)%{$reset_color%}%% '
        PROMPT=$'${vcs_info_msg_0_}%{${fg[yellow]}%}%~ %F{yellow}@${HOST%%.*}[r:$(rbenv_version)]%f\n%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/h-i!(;_;%)..?)%{$reset_color%}%% '
        #PROMPT=$'${vcs_info_msg_0_}%{${fg[yellow]}%}%~ %F{yellow}@${HOST%%.*}[r:$(rbenv_version)]%f\n%(?.%{$bg[green]%}.%{$bg[blue]%})%(?!(._.)/h-i!(;_;%)..?)%{$reset_color%}%% '
        PROMPT2="%{$bg[blue]%}%_>%{$reset_color%}%b "
        SPROMPT="%{$bg[red]%}%{$suggest%}(._.%)? %B %r is correct? [n,y,a,e]:%{${reset_color}%}%b "

        # autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

        # function rprompt-git-current-branch {
        #     local name st color gitdir action
        #     if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
        #         return
        #     fi

        #     name=`git rev-parse --abbrev-ref=loose HEAD 2> /dev/null`
        #     if [[ -z $name ]]; then
        #         return
        #     fi

        #     gitdir=`git rev-parse --git-dir 2> /dev/null`
        #     action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

        #     st=`git status 2> /dev/null`
	    #     if [[ "$st" =~ "(?m)^nothing to" ]]; then
        #         color=%F{green}
	    #     elif [[ "$st" =~ "(?m)^nothing added" ]]; then
        #         color=%F{yellow}
	    #     elif [[ "$st" =~ "(?m)^# Untracked" ]]; then
        #         color=%B%F{red}
        #     else

        #         echo "$color$name$action%f%b "
        # }

        # # PCRE 互換の正規表現を使う
        # setopt re_match_pcre

        # # プロンプトが表示されるたびにプロンプト文字列を評価、置換する
        # setopt prompt_subst

        # RPROMPT='[`rprompt-git-current-branch`%~]'

        RPROMPT=''

        # precmd () {
        #     LANG=en_US.UTF-8 vcs_info
        # #LOADAVG=$(sysctl -n vm.loadavg | perl -anpe '$_=$F[1]')
        #     LOADAVG=''
        #     PROMPT='${vcs_info_msg_0_}%{${fg[yellow]}%}%* ($LOADAVG) %%%{$reset_color%} '
        # }
        # # RPROMPT='%{${fg[green]}%}%/%{$reset_color%}'

        # if [ $TERM = "screen" -o $TERM = "xterm-256color" ]; then
        #     #screenだとここ変更
        #     precmd(){
        #         LANG=en_US.UTF-8 vcs_info
        #         LOADAVG=''
        #         PROMPT='${vcs_info_msg_0_}%{${fg[yellow]}%}%~%%%{$reset_color%} '
        #         RPROMPT='%F{yellow}[r:`~/.rvm/bin/rvm-prompt`]%f'
        #         screen -X title $(basename $(print -P "%~"))
        #     }
        #     preexec(){
        #         screen -X eval "title '$1'"
        #     }
        # fi
        # SPROMPT="%r is correct? [n,y,a,e]: "

        ;;

esac

# set terminal title including current directory
case "${TERM}" in
# for emacs tramp setting
dumb | emacs)
    PROMPT="%n@%~%(!.#.$)"
    RPROMPT=""
    PS1='%(?..[%?])%!:%~%# '
    # for tramp to not hang, need the following. cf:
    # http://www.emacswiki.org/emacs/TrampMode
    unsetopt zle
    unsetopt prompt_cr
    unsetopt prompt_subst
    unfunction precmd
    unfunction preexec
    ;;
# screen)
#     precmd () {
#         screen -xR title $(basename $(print -P "%~"))
#     }
#     preexec () {
#         screen -xR eval "title '$1'"
#     }
#     ;;
# tmux)
#     precmd(){
#         tmux rename-window $(basename $(print -P "%~"))
#     }
#     preexec(){
#         tmux rename-window "$1"
#     }
#     ;;
*)
esac


#screenじの設定
# tmuxとか下のやつみればできるじゃねーの
# http://d.hatena.ne.jp/tyru/20100828/run_tmux_or_screen_at_shell_startup
# if [ ! -z "$WINDOW" ]; then
#     precmd () {
#         screen -X title $(basename $(print -P "%~"))
#     }
#     preexec () {
#         screen -X eval "title '$1'"
#     }
# fi

# case "$TERM" in
#     dumb | emacs)
#         PROMPT="%m:%~> "
#         RPROMPT=""
#         unsetopt zle
#     ;;

#     #*)
# #git updateはもういらない
# #         #git update if you choose yes
# #         echo -n "update my git repos?[Yn]:"
# #         read confirm
# #         case $confirm in
# #         y|Y)
# #             echo "ok.let's start update..."
# #             cd ~/repos
# #             git pull
# #             cd $HOME

# #        ;;
# #         *)
# #         ;;
# #         esac
# #     ;;
# esac
