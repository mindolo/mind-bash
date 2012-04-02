# force ignoredups and ignorespace                                                                                                                                                      
HISTCONTROL=ignoreboth 

# check the window size after each command and, if necessary,                                                                                                                                  
# update the values of LINES and COLUMNS.                                                                                                                                                      
shopt -s checkwinsize


Loading platform dependent configuration if present
if [ -d ~/.bash ]; then

	# Check the OS, and source the appropriate file
	os=$(uname)
	case $os in
		"Darwin")
			source ~/.bash/bashrc_osx
			;;
		"Linux")
			source ~/.bash/bashrc_linux
			;;
		*)
			;;
	esac
fi

#Load the local bash configuration if present
if [ -r ~/.bashrc_local ]; then
	source ~/.bashrc_local
fi

# If this is an interactive shell and the file is present,
# source also git-prompt.sh
if [ -r ~/.bash/git-prompt.sh ]; then
	[[ $- == *i* ]]   &&   . ~/.bash/git-prompt.sh
fi
