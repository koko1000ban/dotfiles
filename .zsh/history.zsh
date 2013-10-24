HISTFILE=$HOME/.zsh_history           # 履歴をファイルに保存する
HISTSIZE=100000                       # メモリ内の履歴の数
SAVEHIST=100000                       # 保存される履歴の数

#重複排除
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt share_history
setopt extended_history               # 履歴ファイルに時刻を記録
function history-all { history -E 1 } # 全履歴の一覧を出力する

# autoload history-search-end
# zle -N history-beginning-search-backward-end history-search-end
# zle -N history-beginning-search-forward-end history-search-end

# bindkey '^p' history-beginning-search-backward
# bindkey '^n' history-beginning-search-forward

# #20110222　再度設定してみた
# bindkey '^r' history-incremental-pattern-search-backward
# bindkey '^s' history-incremental-pattern-search-forward
# bindkey '^R' history-incremental-pattern-search-backward
# bindkey '^S' history-incremental-pattern-search-forward

# anything-history ()  {
#     tmpfile=/tmp/.azh-tmp-file
#     emacsclient --eval '(anything-zsh-history-from-zle)' > /dev/null
#     zle -U "`cat $tmpfile`"
#     # rm $tmpfile
# }
# zle -N anything-history
# bindkey "^T" anything-history

# #http://nanabit.net/blog/2009/06/24/zsh-smart-search-history/
# # complete from history ignoring leading (sudo, '|', man, which, ..) in current prompt
# # only complete in this way if there are some other input than those ignoring patterns
# # examples with history:
# #  ldconfig
# #  make
# #  make install
# #  less
# # case:
# #  $ sudo <C-P>  => $ sudo ldconfig
# #  $ sudo m<C-P>  => $ sudo make install => $ sudo make
# #  $ wget -O - http://.../ | l<C-P> => $ wget -O - http://.../ | less
# SMART_SEARCH_HISTORY_PATTERN='(sudo|\||man|which)'
# function smart-search-history {
#   local trim="$(echo "$LBUFFER" | sed -r "s/^.*${SMART_SEARCH_HISTORY_PATTERN} *//")"
#   local old_leader="$(echo "$LBUFFER" | sed -r "/${SMART_SEARCH_HISTORY_PATTERN}/s/(^.*${SMART_SEARCH_HISTORY_PATTERN} *).+?$/\\1/p;d")"
#   if [ -n "$trim" ]; then
#     LBUFFER="$trim"
#     zle $1
#     LBUFFER="$old_leader""$LBUFFER"
#   else
#     zle $1
#   fi
# }
# function smart-search-history-backward {
#   smart-search-history history-beginning-search-backward
# }
# function smart-search-history-forward {
#   smart-search-history history-beginning-search-forward
# }

# zle -N smart-search-history-backward
# bindkey '^P' smart-search-history-backward
# zle -N smart-search-history-forward
# bindkey '^N' smart-search-history-forward


# スペースを補完候補に含める設定
#http://subtech.g.hatena.ne.jp/cho45/20100814/1281726377
# abbr
typeset -A abbreviations
abbreviations=(
	"L"    "| \$PAGER"
    	"G"    "| grep"

	"H"     "$HOME/project/Hatena-"

	"HE"    "lib/**/Engine/"
	"HM"    "lib/**/MoCo/"
	"HA"    "lib/**/App/"
	"HC"    "lib/**/Config.pm"

	"HEAD^"     "HEAD\\^"
	"HEAD^^"    "HEAD\\^\\^"
	"HEAD^^^"   "HEAD\\^\\^\\^"
	"HEAD^^^^"  "HEAD\\^\\^\\^\\^\\^"
	"HEAD^^^^^" "HEAD\\^\\^\\^\\^\\^"

	# typo
	# "lkm"  "lm"
	# "it"  "git"
	# "gitp"  "git"

	# "mysql" "mysql -unobody -pnobody -h"
)

magic-abbrev-expand () {
	local MATCH
	LBUFFER=${LBUFFER%%(#m)[-_a-zA-Z0-9^]#}
	LBUFFER+=${abbreviations[$MATCH]:-$MATCH}
}

# BK
magic-space () {
	magic-abbrev-expand
	zle self-insert
}

magic-abbrev-expand-and-insert () {
	magic-abbrev-expand
	zle self-insert
}

magic-abbrev-expand-and-insert-complete () {
	magic-abbrev-expand
	zle self-insert
	zle expand-or-complete
}

magic-abbrev-expand-and-accept () {
	magic-abbrev-expand
	zle accept-line
}

magic-abbrev-expand-and-normal-complete () {
	magic-abbrev-expand
	zle expand-or-complete
}

no-magic-abbrev-expand () {
	LBUFFER+=' '
}

zle -N magic-abbrev-expand
zle -N magic-abbrev-expand-and-magic-space
zle -N magic-abbrev-expand-and-insert
zle -N magic-abbrev-expand-and-insert-complete
zle -N magic-abbrev-expand-and-normal-complete
zle -N magic-abbrev-expand-and-accept
zle -N no-magic-abbrev-expand
zle -N magic-space # BK
bindkey "\r"  magic-abbrev-expand-and-accept # M-x RET できなくなる
bindkey "^J"  accept-line # no magic
bindkey " "   magic-space # BK
bindkey "."   magic-abbrev-expand-and-insert
bindkey "^I"  magic-abbrev-expand-and-normal-complete


function exists { which $1 &> /dev/null }

if exists percol; then
    unalias history
    function ppgrep() {
        if [[ $1 == "" ]]; then
            PERCOL=percol
        else
            PERCOL="percol --query $1"
        fi
        ps aux | eval $PERCOL | awk '{ print $2 }'
    }

    function ppkill() {
        if [[ $1 =~ "^-" ]]; then
            QUERY=""            # options only
        else
            QUERY=$1            # with a query
            [[ $# > 0 ]] && shift
        fi
        ppgrep $QUERY | xargs kill $*
    }

    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(history -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER         # move cursor
        zle -R -c               # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
    bindkey '^K' ppkill
fi
