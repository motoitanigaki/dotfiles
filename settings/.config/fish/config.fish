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


status --is-interactive; and source (pyenv init - | psub)

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/motoi/Documents/gcp/google-cloud-sdk/path.fish.inc' ]; . '/Users/motoi/Documents/gcp/google-cloud-sdk/path.fish.inc'; end

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# pnpm
set -gx PNPM_HOME "/Users/motoi/Library/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
if test -f /Users/motoi/miniconda3/bin/conda
    eval /Users/motoi/miniconda3/bin/conda "shell.fish" "hook" $argv | source
else
    if test -f "/Users/motoi/miniconda3/etc/fish/conf.d/conda.fish"
        . "/Users/motoi/miniconda3/etc/fish/conf.d/conda.fish"
    else
        set -x PATH "/Users/motoi/miniconda3/bin" $PATH
    end
end
# <<< conda initialize <<<


# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba shell init' !!
set -gx MAMBA_EXE "/Users/motoi/miniconda3/bin/mamba"
set -gx MAMBA_ROOT_PREFIX "/Users/motoi/miniconda3"
$MAMBA_EXE shell hook --shell fish --root-prefix $MAMBA_ROOT_PREFIX | source
# <<< mamba initialize <<<
alias claude="/Users/motoi/.claude/local/claude"

# yazi wrapper - exit to cwd
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    command yazi $argv --cwd-file="$tmp"
    if read -z cwd < "$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end
# Added by Antigravity
fish_add_path /Users/motoi/.antigravity/antigravity/bin

