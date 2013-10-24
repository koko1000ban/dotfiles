
unalias -m ls

# antigen
source ~/.zsh/antigen/antigen.zsh

# Load the oh-my-zsh's library.
antigen-lib

echo " antigen bundle start"
# Bundles from the default repo (robbyrussell's oh-my-zsh).
# antigen-bundle git
# antigen-bundle github
antigen-bundle command-not-found
# antigen-bundle gnu-utils
# antigen-bundle history
antigen-bundle npm
antigen-bundle node
antigen-bundle python
echo " antigen bundle end"

# Syntax highlighting bundle.
antigen-bundle zsh-users/zsh-syntax-highlighting

# # Load the theme.
# antigen-theme wedisagree_custom
antigen-theme koko1000ban/zsh-themes themes/wedisagree_custom

# antigen-update

# Tell antigen that you're done.
antigen-apply
