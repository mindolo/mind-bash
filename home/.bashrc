# Check if we are in an interactive session
# return if not.
case "$-" in
*i*)	;;
*)	return;;
esac


#Load functions file
if [ -e ${HOME}/.bash/functions.sh ]; then
    source ${HOME}/.bash/functions.sh
fi

# add ~/.bash/bin/ to $PATH
export PATH=~/.bash/bin:$PATH

# force ignoredups and ignorespace                                                                                                                                                      
export HISTCONTROL=ignoreboth

# check the window size after each command and, if necessary,                                                                                                                                  
# update the values of LINES and COLUMNS.                                                                                                                                                      
shopt -s checkwinsize

#Loading platform dependent configuration if present
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

# Load the local bash configuration if present
if [ -r ~/.bashrc_local ]; then
	source ~/.bashrc_local
fi

# Load the local aliases file if present
if [ -r ~/.bash_aliases ]; then
	source ~/.bash_aliases
fi

# Load modules
bash_load_modules

# Add a global reload alias to reload the configuration
alias reload='source ~/.bashrc'

# If this is an interactive shell and the submodule is present
# source also liquidprompt
if [ -r ~/.bash//liquidprompt/liquidprompt ]; then
	[[ $- == *i* ]]   &&   . ~/.bash/liquidprompt/liquidprompt
fi
