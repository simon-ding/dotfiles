# Defined in /var/folders/v6/k57bd1_x35j7fd7t80rpq49w0000gn/T//fish.YSkOYb/v.fish @ line 2
function v --description 'open file use fasd and fzf'
	set -l _file  (fasd -Rfl "$argv[1]" | fzf --height=40% -1 -0 --no-sort +m --preview "less {}") && vim $_file || return 1
end
