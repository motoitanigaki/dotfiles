starship init fish | source

# pyenv
status is-interactive; and pyenv init --path | source
pyenv init - | source
export LDFLAGS="-L/usr/local/opt/zlib/lib"
export CPPFLAGS="-I/usr/local/opt/zlib/include"
export PKG_CONFIG_PATH="/usr/local/opt/zlib/lib/pkgconfig"

# brew extra path
set PATH /opt/homebrew/opt/openvpn/sbin/ $PATH
fish_add_path /opt/homebrew/opt/node@14/bin
fish_add_path /opt/homebrew/bin

# nvm
function __check_rvm --on-variable PWD --description 'Do nvm stuff'
  status --is-command-substitution; and return

  if test -f .nvmrc; and test -r .nvmrc;
    nvm use
  else
  end
end

# peco
function peco_select_history_order
  if test (count $argv) = 0
    set peco_flags --layout=top-down
  else
    set peco_flags --layout=bottom-up --query "$argv"
  end
  history|peco $peco_flags|read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

function peco_git_add
  set adding_file = (git status --porcelain | peco --query "$LBUFFER" | awk -F ' ' '{print $NF}')
  if [ $adding_file ]
    set BUFFER "git add (echo "$adding_file" | tr '\n' ' ')"
    set CURSOR #BUFFER
    commandline -f repaint
  end
end

function peco_z
  set -l query (commandline)
  if test -n $query
    set peco_flags --query "$query"
  end
  z -l | peco $peco_flags | awk '{ print $2 }' | read recent
  if [ $recent ]
      cd $recent
      commandline -r ''
      commandline -f repaint
  end
end

function peco_z_code
  set -l query (commandline)
  if test -n $query
    set peco_flags --query "$query"
  end
  z -l | peco $peco_flags | awk '{ print $2 }' | read recent
  if [ $recent ]
      code $recent
      commandline -r ''
      commandline -f repaint
  end
end

function fish_user_key_bindings
  bind \cr 'peco_select_history_order' # Ctrl + R
  bind \cg\ca 'peco_git_add'
  bind \cz 'peco_z'
  bind \cc 'peco_z_code'
end
