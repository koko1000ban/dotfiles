# #自動補完
# #http://bit.ly/9YZHpF
# source ~/.zsh/completion/auto-fu.zsh; zle-line-init () { auto-fu-init; }; zle -N zle-line-init
# zstyle ':completion:*' completer _oldlist _complete

source ~/.zsh/auto-fu.zsh
zstyle ':auto-fu:highlight' input bold
zstyle ':auto-fu:highlight' completion fg=black,bold
zstyle ':auto-fu:var' postdisplay $'\n-autofu-'

# スペース後の補完をoffる
zstyle ':auto-fu:var' disable magic-space

zle-line-init () {auto-fu-init;}; zle -N zle-line-init
zstyle ':completion:*' completer _oldlist _complete

#auto-fu.zshスラッシュ2個つくのを防ぐ
# unsetopt autoremoveslash

# # delete unambiguous prefix when accepting line
# # http://d.hatena.ne.jp/tarao/20100823/1282543408
# function afu+delete-unambiguous-prefix () {
#     afu-clearing-maybe
#     local buf; buf="$BUFFER"
#     local bufc; bufc="$buffer_cur"
#     [[ -z "$cursor_new" ]] && cursor_new=-1
#     [[ "$buf[$cursor_new]" == ' ' ]] && return
#     [[ "$buf[$cursor_new]" == '/' ]] && return
#     ((afu_in_p == 1)) && [[ "$buf" != "$bufc" ]] && {
#         # there are more than one completion candidates
#         zle afu+complete-word
#         [[ "$buf" == "$BUFFER" ]] && {
#             # the completion suffix was an unambiguous prefix
#             afu_in_p=0; buf="$bufc"
#         }
#         BUFFER="$buf"
#         buffer_cur="$bufc"
#     }
# }
# zle -N afu+delete-unambiguous-prefix
# function afu-ad-delete-unambiguous-prefix () {
#     local afufun="$1"
#     local code; code=$functions[$afufun]
#     eval "function $afufun () { zle afu+delete-unambiguous-prefix; $code }"
# }
# afu-ad-delete-unambiguous-prefix afu+accept-line
# afu-ad-delete-unambiguous-prefix afu+accept-line-and-down-history
# afu-ad-delete-unambiguous-prefix afu+accept-and-hold

#C-g,escでキャンセル
#http://d.hatena.ne.jp/tarao/20100531/1275322620
# afu+cancel
function afu+cancel () {
    afu-clearing-maybe
    ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur"; }
}
function bindkey-advice-before () {
    local key="$1"
    local advice="$2"
    local widget="$3"
    [[ -z "$widget" ]] && {
        local -a bind
        bind=(`bindkey -M main "$key"`)
        widget=$bind[2]
    }
    local fun="$advice"
    if [[ "$widget" != "undefined-key" ]]; then
        local code=${"$(<=(cat <<"EOT"
            function $advice-$widget () {
                zle $advice
                zle $widget
            }
            fun="$advice-$widget"
EOT
        ))"}
        eval "${${${code//\$widget/$widget}//\$key/$key}//\$advice/$advice}"
    fi
    zle -N "$fun"
    bindkey -M afu "$key" "$fun"
}
bindkey-advice-before "^G" afu+cancel
bindkey-advice-before "^[" afu+cancel
bindkey-advice-before "^J" afu+cancel afu+accept-line

#ふるいやつ
# function afu+cancel () {
#     afu-clearing-maybe
#     ((afu_in_p == 1)) && { afu_in_p=0; BUFFER="$buffer_cur" }
# }
# function afu-bindkey-advice-before () {
#     local key="$1"
#     local advice="$2"
#     local -a bind
#     bind=(`bindkey -M main "$key"`)
#     local widget=$bind[2]
#     local fun="$advice"
#     if [[ "$widget" != "undefined-key" ]]; then
#         local code=${"$(<=(cat <<"EOT"
#             (( $+functions[afu+$widget] )) || function afu+$widget () {
#                 zle $advice
#                 zle $widget
#             }
#             fun="afu+$widget"
# EOT
#         ))"}
#         eval "${${${code//\$widget/$widget}//\$key/$key}/\$advice/$advice}"
#     fi
#     zle -N "$fun"
#     bindkey -M afu "$key" "$fun"
# }
# afu-bindkey-advice-before "^G" afu+cancel
# afu-bindkey-advice-before "^[" afu+cancel


