
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$HOME/MY_ZSH_SCRIPTS:$PATH"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting) 

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='nvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch $(uname -m)"

# Set personal aliases, overriding those provided by Oh My Zsh libs,
# plugins, and themes. Aliases can be placed here, though Oh My Zsh
# users are encouraged to define aliases within a top-level file in
# the $ZSH_CUSTOM folder, with .zsh extension. Examples:
# - $ZSH_CUSTOM/aliases.zsh
# - $ZSH_CUSTOM/macos.zsh
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
eval "$(starship init zsh)"
neofetch
# source /opt/ros/noetic/setup.zsh
# alias rosinfo="printenv | grep ROS"
alias source_zsh="source ~/.zshrc"

alias qp="batcat --show-all"
alias catkin_build="cd ~/catkin && source devel/setup.zsh"
alias orca_slicer="cd && ./MY_ZSH_SCRIPTS/OPENORCA.zsh"
alias rusty="cd ~/.cargo"
alias update_check="check_updates.zsh"
alias matlab="cd ~/ && /home/edan/EdanPrograms/MatLab/bin/matlab"
alias ros1-docker="~/MY_ZSH_SCRIPTS/ros_docker/run.sh ros1"
alias ros2-docker="~/MY_ZSH_SCRIPTS/ros_docker/run.sh ros2"



# ----- ROS setup -----
# Order matters: define the use_ros1/use_ros2 switcher first, then pick a
# default for new shells (ROS2 Humble), THEN register ros2/colcon
# autocomplete (needs ROS2 already sourced), THEN run ros_env_setup.zsh
# (domain ID / localhost-only prompts) which reads the env vars use_ros2 set.
# To switch to ROS1 (ROS-O) in a running shell, just run: use_ros1
source ~/MY_ZSH_SCRIPTS/ros_switch.zsh
use_ros2
echo "Active ROS distro: $ROS_DISTRO (run 'use_ros1' to switch to ROS1/ROS-O)"

eval "$(register-python-argcomplete3 ros2)"
eval "$(register-python-argcomplete3 colcon)"

cd ~/MY_ZSH_SCRIPTS

./ros_env_setup.zsh

cd ~/


# ----- tmux shortcuts -----

alias ta='tmux attach-session'
alias td='tmux detach'
alias ts='tmux new-session -s'
alias tls='tmux list-sessions'

# Fuzzy attach (choose session interactively)
tfa() {
    session=$(tmux list-sessions -F '#{session_name}' 2>/dev/null | fzf)
    [ -n "$session" ] && tmux attach-session -t "$session"
}

# Fuzzy kill session
tk() {
    session=$(tmux list-sessions -F '#{session_name}' 2>/dev/null | fzf)
    [ -n "$session" ] && tmux kill-session -t "$session"
}



# ===== tmux menu (tmenu) =====

# cross-shell read prompt
_prompt() {
    # usage: _prompt var "Prompt text"
    if [ -n "$ZSH_VERSION" ]; then
        read -r "$1?$2"
    else
        read -r -p "$2" "$1"
    fi
}

tmenu() {
    sessions=$(tmux list-sessions -F '#{session_name}' 2>/dev/null)

    opts="New Session"
    if [ -n "$sessions" ]; then
        opts="$opts
Attach Session
Switch Session
Kill Session
Rename Session
List Sessions"
    fi

    choice=$(printf "%s\n" "$opts" | fzf --prompt="tmux menu > ")

    case "$choice" in
        "New Session")
            _prompt name "New session name: "
            [ -n "$name" ] && tmux new -s "$name"
            ;;

        "Attach Session")
            session=$(echo "$sessions" | fzf --prompt="attach > ")
            [ -n "$session" ] && tmux attach -t "$session"
            ;;

        "Switch Session")
            session=$(echo "$sessions" | fzf --prompt="switch > ")
            [ -n "$session" ] && tmux switch-client -t "$session"
            ;;

        "Kill Session")
            session=$(echo "$sessions" | fzf --prompt="kill > ")
            if [ -n "$session" ]; then
                _prompt c "Kill session '$session'? (y/N) "
                [ "$c" = "y" ] && tmux kill-session -t "$session"
            fi
            ;;

        "Rename Session")
            session=$(echo "$sessions" | fzf --prompt="rename > ")
            if [ -n "$session" ]; then
                _prompt new "New name for '$session': "
                [ -n "$new" ] && tmux rename-session -t "$session" "$new"
            fi
            ;;

        "List Sessions")
            tmux list-sessions
            ;;
    esac
}
