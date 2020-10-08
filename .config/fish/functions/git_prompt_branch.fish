# Defined in /var/folders/br/tfxpk7t13_14zmhw4q620_680000gn/T//fish.IU5axE/git_prompt_branch.fish @ line 2
function git_prompt_branch --description 'Output git branch information'
	set -l is_git_repository (git rev-parse --is-inside-work-tree ^/dev/null)

  # Print the current git branch name or shortened commit hash in colour.
  #
  # Green means the working directory is clean.
  # Yellow means all changed files have been staged.
  # Red means there are changed files that are not yet staged.
  #
  # Untracked files are ignored.
  if test -n "$is_git_repository"
      set -l branch (git symbolic-ref --short HEAD ^/dev/null; or git show-ref --head -s --abbrev | head -n1 ^/dev/null)

      git diff-files --quiet --ignore-submodules ^/dev/null; or set -l has_unstaged_files
      git diff-index --quiet --ignore-submodules --cached HEAD ^/dev/null; or set -l has_staged_files

      if set -q has_unstaged_files
          set_color red
      else if set -q has_staged_files
          set_color yellow
      else
          set_color green
      end
      echo -n $branch

      git rev-parse --abbrev-ref '@{upstream}' >/dev/null ^&1; and set -l has_upstream
      if set -q has_upstream
          set -l commit_counts (git rev-list --left-right --count 'HEAD...@{upstream}' ^/dev/null)

          set -l commits_to_push (echo $commit_counts | cut -f 1 ^/dev/null)
          set -l commits_to_pull (echo $commit_counts | cut -f 2 ^/dev/null)

          if test $commits_to_push != 0
              if test $commits_to_pull -ne 0
                  set_color red
              else if test $commits_to_push -gt 3
                  set_color yellow
              else
                  set_color green
              end
              echo -n " ⇡$commits_to_push"
          end

          if test $commits_to_pull != 0
              if test $commits_to_push -ne 0
                  set_color red
              else if test $commits_to_pull -gt 1
                  set_color white
              else
                  set_color green
              end
              echo -n " ⇣$commits_to_pull"
          end
      end


      # Print a "stack symbol" if there are stashed changes.
      #if test (git stash list | wc -l) -gt 0
      #    set_color --bold black
      #    echo -n " ☰"
      #end

      set_color normal
  end
end
