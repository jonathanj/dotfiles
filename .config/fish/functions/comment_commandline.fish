function comment_commandline --description 'Comment the existing command line and commit it to history'
	set -l _cl (commandline)
        if test -z $_cl
            return
        end
	commandline (echo -sn "#$_cl")
        commandline -f execute
end
