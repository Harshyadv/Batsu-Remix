# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Ruby Gem Setup
export GEM_HOME="$HOME/.gems"
export PATH="$HOME/.gems/bin:$PATH"

# --- BATSU-LITE (Stock Hybrid) ---

# 1. Smart Git Logic
batsu_git() {
    local branch=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    [ -z "$branch" ] && return

    local status_color="\[\e[32m\]" # Green
    [[ -n $(git status -s 2> /dev/null) ]] && status_color="\[\e[31m\]" # Red if dirty
    
    local ahead=$(git rev-list --count @{u}..HEAD 2>/dev/null)
    local behind=$(git rev-list --count HEAD..@{u} 2>/dev/null)
    local remote=""
    [ "$ahead" -gt 0 ] && remote+=" +$ahead" 
    [ "$behind" -gt 0 ] && remote+=" -$behind" 
    
    echo -e " ${status_color}(${branch}${remote})\[\e[0m\]"
}

# 2. Python Venv
batsu_venv() {
    [ -n "$VIRTUAL_ENV" ] && echo -e " \[\e[35m\][py]\[\e[0m\]"
}

# 3. Navigation Aliases (Fish-style)
alias ..='cd ..'
alias ...='cd ../..'

# Jekyll Development Alias
alias jserve='bundle exec jekyll serve --baseurl /HYDV'

# 4. Just change this line: no more export
PS1="\[\e[37m\][\t] \[\e[32m\]\u@\h \[\e[34m\]\w\$(batsu_venv)\$(batsu_git) \[\e[32m\]\$ \[\e[0m\]"
