# Defined in /var/folders/v6/k57bd1_x35j7fd7t80rpq49w0000gn/T//fish.lYm2HT/fish_user_key_bindings.fish @ line 10
function bind_dollar
	switch (commandline -t)
  case "!"
    commandline -t ""
    commandline -f history-token-search-backward
  case "*"
    commandline -i '$'
  end
end
