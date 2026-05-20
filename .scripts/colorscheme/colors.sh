#!/usr/bin/env bash

LIBRARYS=(
  animation signal cursor colors stat
)

LIBRARY_PATH="${HOME}/.scripts/library"

for LIBRARY in ${LIBRARYS[@]}; do
  source ${LIBRARY_PATH}/${LIBRARY}.sh
done

COLORSCHEMES_DIR="$HOME/.colorscheme"

THEME_USED_PATH="${HOME}/.config/mytermux/colorscheme"
THEME_USED_FILE_NAME="used.log"
THEME_USED="$(cat ${THEME_USED_PATH}/${THEME_USED_FILE_NAME})"

TERMUX_CONFIGURATION_PATH="${HOME}/.termux"
TERMUX_CONFIGURATION_COLOR_FILE_NAME="colors.properties"

function listColorScheme() {

  clear
  setCursor off

  gum style --border=rounded --border-foreground="5" --padding="1 2" --margin="1" \
    "🎨 Colorscheme Switcher" \
    "" \
    "Current: $THEME_USED"

  local choices=()
  local names=()

  for COLORSCHEME in ${COLORSCHEMES_DIR}/*; do
    local name=$(echo ${COLORSCHEME} | awk -F'/' '{print $NF}' | sed "s/.colors//g")
    local filename=$(echo ${COLORSCHEME} | awk -F'/' '{print $NF}')
    names+=("$filename")
    if [ "${THEME_USED}" == "${filename}" ]; then
      choices+=("$name ✓")
    else
      choices+=("$name")
    fi
  done

  local selected=$(gum choose "${choices[@]}")
  local index=0
  for choice in "${choices[@]}"; do
    if [ "$choice" == "$selected" ]; then
      local chosen_name="${names[$index]}"
      break
    fi
    index=$((index + 1))
  done

  if [ -z "$chosen_name" ]; then
    return
  fi

  gum spin --title "Applying theme ..." -- \
    cp -fr "${COLORSCHEMES_DIR}/${chosen_name}" "${TERMUX_CONFIGURATION_PATH}/${TERMUX_CONFIGURATION_COLOR_FILE_NAME}"

  termux-reload-settings

  if [ ! -f ${THEME_USED_PATH}/${THEME_USED_FILE_NAME} ]; then
    echo "${chosen_name}" >> ${THEME_USED_PATH}/${THEME_USED_FILE_NAME}
  else
    sed -i "s/${THEME_USED}/${chosen_name}/g" ${THEME_USED_PATH}/${THEME_USED_FILE_NAME}
  fi

  stat "SUCCESS" "Success" "Theme applied: $chosen_name"

}

function main() {

  trap 'handleInterruptByUser "Interrupt by User"' 2

  listColorScheme

}

main
