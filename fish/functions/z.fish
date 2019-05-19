# Defined in /var/folders/v6/k57bd1_x35j7fd7t80rpq49w0000gn/T//fish.lNdhdb/z.fish @ line 2
function z --description 'interactively changing directory'
	set -l _dir  (fasd -Rdl "$argv[1]" | fzf --height=40% -1 -0 --no-sort +m --preview "gls --color -1 {}") && cd $_dir || return 1
end
