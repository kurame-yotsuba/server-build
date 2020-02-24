# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
PATH="$HOME/.local/bin:$HOME/bin:$PATH"
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

#================================================
# User specific aliases and functions
#================================================

publish_dir="$HOME/fshome/publish"

function running() {
    ps alx | grep -v "grep" | grep "dotnet"
}

function z-vlog() {
    vim $publish_dir/ZuyurisanBot/ZuyurisanBot.log
}
function z-tlog() {
    tail -n 20 $publish_dir/ZuyurisanBot/ZuyurisanBot.log
}

function z-logcount() {
    cat $publish_dir/ZuyurisanBot/ZuyurisanBot.log | wc
}

function z-tlcount() {
    cat $publish_dir/ZuyurisanBot/Timeline.json | grep "UserId" | wc
}

function z-goto() {
    cd $publish_dir/ZuyurisanBot
}

function z-run() {
    pushd $publish_dir/ZuyurisanBot
    at -f $publish_dir/ZuyurisanBot/run.sh now
    popd
}

function z-end() {
    echo "exit" > $publish_dir/ZuyurisanBot/ZuyurisanBot.state
}

function showmail() {
    vi /var/spool/mail/gen
}

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


