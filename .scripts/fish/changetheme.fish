#!/usr/bin/env fish

function banner
  gum style --border=rounded --border-foreground="5" --padding="1 2" --margin="1" \
    "🐟 Fish Theme Switcher"
end

function listFishTheme
  clear
  set -l THEME_USED (cat $HOME/.config/mytermux/fish/used.log 2>/dev/null)
  if test -z "$THEME_USED"
    set THEME_USED "none"
  end

  gum style --border=rounded --border-foreground="4" --padding="1 2" --margin="1" \
    "Current theme: $THEME_USED"

  set -l choices lean classic full fresh rainbow
  set -l display_choices

  for FISH_THEME in $choices
    if test "$THEME_USED" = "$FISH_THEME"
      set display_choices $display_choices "$FISH_THEME ✓"
    else
      set display_choices $display_choices "$FISH_THEME"
    end
  end

  set -l selected (gum choose $display_choices)
  set -l CHOICE (string replace " ✓" "" "$selected")

  if test -z "$CHOICE"
    return
  end

  gum spin --title "Applying theme: $CHOICE ..." -- sleep 1

  set -l THEME_USED_PATH "$HOME/.config/mytermux/fish"
  set -l THEME_USED_FILE "$THEME_USED_PATH/used.log"

  if test ! -d "$THEME_USED_PATH"
    mkdir -p "$THEME_USED_PATH"
  end

  echo "$CHOICE" > "$THEME_USED_FILE"

  gum spin --title "Configuring Tide preset: $CHOICE ..." -- \
    tide configure --auto --style="$CHOICE" 2>/dev/null

  gum style --border=rounded --border-foreground="2" --padding="1 2" --margin="1" \
    "✅ Theme applied. Restarting fish..."

  exec fish
end

function main
  set -l THEME_USED (cat $HOME/.config/mytermux/fish/used.log 2>/dev/null)

  if test -z "$THEME_USED"
    echo "lean" > $HOME/.config/mytermux/fish/used.log
  end

  banner
  listFishTheme
end

main
