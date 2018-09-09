function fish_title
	if test -n "$TMUX"
        tmux-title "$_ $argv"
    else
        echo $_ ' '
        pwd
    end
end
