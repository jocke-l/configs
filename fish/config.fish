set -U fish_greeting

set -Ux BROWSER firefox
set -Ux EDITOR nvim
set -Ux TERM xterm-256color

set -Ux _JAVA_OPTIONS '-Dawt.useSystemAAFontSettings=gasp -Dswing.aatext=true'
set -Ux _JAVA_AWT_WM_NONREPARENTING 1

set -Ux XDG_CONFIG_DIR $HOME/.config
set -Ux XDG_RUNTIME_DIR /run/user/(id -u)

set -Ux SSH_AUTH_SOCK $XDG_RUNTIME_DIR/ssh-agent.sock

set -Ux FZF_DEFAULT_COMMAND 'fd --type f'

set -Ux GPG_TTY (tty)

set -U fish_user_paths /usr/local/bin/ /home/(whoami)/.local/bin

set -U fish_user_paths $HOME/.krew/bin $fish_user_paths

set -Ux PYENV_ROOT $HOME/.pyenv
set -U fish_user_paths $PYENV_ROOT/bin $fish_user_paths

set -U fish_user_paths $HOME/bin $fish_user_paths

if status --is-interactive
    eval (direnv hook fish)
    pyenv init - | source
end

if status is-login
    if test -z "$DISPLAY" -a $XDG_VTNR = 1
        exec startx -- -keeptty
    end
end

alias vim nvim
alias ls='ls -h --group-directories-first --color=auto'
alias task go-task
