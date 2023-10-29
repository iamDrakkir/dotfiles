#!/bin/sh

## autoload vcs
autoload -Uz vcs_info
autoload -U colors && colors

# enable only git
zstyle ':vcs_info:*' enable git

# setup a hook that runs before every ptompt.
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst

# add a function to check for untracked files in the directory.
# from https://github.com/zsh-users/zsh/blob/master/Misc/vcs_info-examples
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
#
+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        # This will show the marker if there are any untracked files in repo.
        # If instead you want to show the marker only if there are untracked
        # files in $PWD, use:
        #[[ -n $(git ls-files --others --exclude-standard) ]] ; then
        hook_com[staged]+='!' # signify new files with a bang
    fi
}

zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git:*' formats "%{$fg[blue]%}(%{$fg[red]%}%m%u%c%{$fg[yellow]%}%{$fg[magenta]%} %b%{$fg[blue]%})"

##
# Left hand side
##

user="%F{4}%n%{$reset_color%}"
usersep="%F{15}@%{$reset_color%}"
machine="%F{4}%m%{$reset_color%}"
at="%F{15}at%{$reset_color%}"
on="on"
relativeHome="%F{4}%~%{$reset_color%}"
carriageReturn=""$'\n'""
emptyLineBottom="%r"
chevronRight=""
cmdPrompt="%(?:%F{2}${chevronRight} :%F{1}${chevronRight} )"
git_info="\$vcs_info_msg_0_"

function separator() {
  # tput setaf to set to terminal color 0
  # printf command is used to format and print text to the terminal
  # The %*s format specifier is used to print a string, where the * indicates that the width of the string should be specified as an argument
  # The ${COLUMNS:-$(tput cols)} expression is used to determine the width of the terminal window.
  # The COLUMNS variable is set by the shell to the number of columns in the terminal window, and the tput cols command retrieves the number of columns in the terminal window. The :- operator is used to set a default value for the COLUMNS variable if it is not set. In this case, the default value is the output of the tput cols command, which retrieves the number of columns in the terminal window.
  # the tr command is used to replace all spaces in the input string with -
  separation_line=$(tput setaf 0; printf '%*s\n' "${COLUMNS:-$(tput cols)}" '' | tr ' ' -)
  echo "${separation_line}"
}

function precmd() {
  separator
}

PROMPT="${user}${usersep}${machine} ${at} ${relativeHome} ${git_info} ${carriageReturn}${cmdPrompt}%{$reset_color%"


##
# Right hand side
##

# format right-side prompt with execution time of last command.
function preexec() {
  timer=$(($(date +%s%0N)/1000000))
}

function precmd() {
  if [ $timer ]; then
    now=$(($(date +%s%0N)/1000000))
    elapsed=$(($now-$timer))

    if [ ${elapsed} -gt 60000 ]; then
      elapsed=$((${elapsed}/60000))
      unit='min'
    elif [ ${elapsed} -gt 1000 ]; then
      elapsed=$((${elapsed}/1000))
      unit='s'
    else
      unit='ms'
    fi
    export RPROMPT="%F{blue}${elapsed}${unit} %{$reset_color%}"
    unset timer
  fi
}
