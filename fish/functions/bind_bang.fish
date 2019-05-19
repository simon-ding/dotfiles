# Defined in /var/folders/v6/k57bd1_x35j7fd7t80rpq49w0000gn/T//fish.lYm2HT/fish_user_key_bindings.fish @ line 1
function bind_bang
	switch (commandline -t)
  case "!"
    commandline -t $history[1]; commandline -f repaint
  case "*"
    commandline -i !
  end
end
