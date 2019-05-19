# Defined in /var/folders/v6/k57bd1_x35j7fd7t80rpq49w0000gn/T//fish.ue1Bfo/log.fish @ line 1
function log --description 'git commit browser. uses fzf'
	git log --graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" $argv | \
  fzf --ansi --no-sort --reverse --tiebreak=index --toggle-sort=\` --bind "ctrl-m:execute:
                echo '{}' | grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R'"
end
