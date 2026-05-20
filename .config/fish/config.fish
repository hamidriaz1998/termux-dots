# PATH
if not contains $PREFIX/bin $PATH
  fish_add_path $PREFIX/bin
end

if not contains $HOME/.local/bin $PATH
  fish_add_path $HOME/.local/bin
end

# Environment variables
set -gx LINK "https://github.com/mayTermux"
set -gx LINK_SSH "git@github.com:mayTermux"
set -gx TERM xterm-256color

# Fisher plugins
# Managed via fish_plugins file — sync with: fisher install
# - jorgebucaran/fisher (plugin manager)
# - IlanCosman/tide (prompt theme)
# - patrickf1/fzf.fish (fzf integration)

# Source aliases & autostart
source $HOME/.aliases
source $HOME/.autostart
