#############
# options
#############
setopt bash_auto_list
setopt list_ambiguous
setopt auto_pushd

#allow tab completion in the middle of a word
setopt COMPLETE_IN_WORD

#history append
setopt append_history

#disable autocorrect
unsetopt correct_all

#auto_cd
setopt auto_cd

# complite after =
setopt magic_equal_subst

# allow regex file name
setopt extended_glob

# complete history
setopt hist_expand

# #color
# setopt prompt_subst

# show type mark
setopt list_types

#show complition list
setopt auto_list
setopt list_packed
setopt auto_menu

#8bit ok
setopt print_eightbit

#set color complition
#eval `dircolors`
#export ZLS_COLORS=$LS_COLORS
#zstyle ':completion:*:default' list-color ${(s.:.)LS_COLORS}

#かっこを自動補完
setopt auto_param_keys

# # /を補完
# setopt auto_param_slash
unsetopt auto_param_slash

#no beep
setopt NO_beep

#2011.05.25 auto-fu.zshと相性が悪いのではずしてみる
#URLをエスケープ
# autoload -Uz url-quote-magic
# zle -N self-insert url-quote-magic

