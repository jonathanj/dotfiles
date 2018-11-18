# Defined in /Users/jonathan/.config/fish/functions/fish_prompt.fish @ line 1
function fish_prompt --description 'Write out the prompt'
  # Status is overwritten as soon as any command is run.
  set -l exit_code $status
  set -l is_git_repository (git rev-parse --is-inside-work-tree ^/dev/null)

	if set -q VIRTUAL_ENV
    echo -n -s (set_color blue) "(" (basename "$VIRTUAL_ENV") ")" (set_color normal) " "
  end

  function __pwd
      pwd | sed -e "s=$HOME=~="
  end

    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
        set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
    end

    if not set -q __fish_prompt_normal
        set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __fish_prompt_user
        set -g __fish_prompt_user (set_color $fish_color_user)
    end

    if not set -q __fish_prompt_host
        set -g __fish_prompt_host (set_color $fish_color_host)
    end

    switch $USER
        case root
            if not set -q __fish_prompt_cwd
                if set -q fish_color_cwd_root
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
                else
                    set -g __fish_prompt_cwd (set_color $fish_color_cwd)
                end
            end
            set -g __fish_prompt_user_indicator '#'

        case '*'
            if not set -q __fish_prompt_cwd
                set -g __fish_prompt_cwd (set_color $fish_color_cwd)
            end
            set -g __fish_prompt_user_indicator '↪'
    end

    echo -s -n \
      (set_color magenta) "$USER" (set_color normal) \
      " in " (set_color --bold blue) (__pwd) (set_color normal)

    set -l git_info (git_prompt_branch)
    if test -n "$git_info"
        echo -s -n " on " $git_info
    end

    echo

    if test $exit_code -ne 0
        set_color --bold red
    else
        set_color --bold green
    end
    echo -n "$__fish_prompt_user_indicator "

    set_color normal
end
