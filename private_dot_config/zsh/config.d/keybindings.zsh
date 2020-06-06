# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"
# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"              beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"               end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"            overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"         backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"            delete-char
#[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"                up-line-or-history
#[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"              down-line-or-history
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"                history-substring-search-up
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"              history-substring-search-down
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"              backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"             forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"            beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"          end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"         reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word
# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget history-substring-search-up history-substring-search-down
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }

	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
	zle -N history-substring-search-up 
	zle -N history-substring-search-down
fi


