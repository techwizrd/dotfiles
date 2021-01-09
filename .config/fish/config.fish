# Load fishmarks (http://github.com/techwizrd/fishmarks)
. $HOME/.fishmarks/marks.fish

## Add Cargo executables to path
set -gx PATH $HOME/.cargo/bin $PATH

## Java
#set -gx JAVA_HOME (/usr/libexec/java_home)
#set -gx PATH "$JAVA_HOME/bin" $PATH

## Golang
# Calling (brew --prefix golang) is slow, so we'll avoid doing this unless
# necessary
#set -gx GOPATH $HOME/.go
#set -gx GOROOT (brew --prefix golang)/libexec
#set -gx PATH $PATH $GOPATH/bin $GOROOT/bin

set -gx EDITOR nvim

alias show_image="kitty +kitten icat"
set ubuntu_logo_location "/usr/share/icons/hicolor/256x256/apps/ubuntu-logo-icon.png"
alias show_ubuntu_logo="show_image $ubuntu_logo_location"

## SSH Agent
fish_ssh_agent

# Disable welcome message
set fish_greeting
