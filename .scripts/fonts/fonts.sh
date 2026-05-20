#!/usr/bin/env bash

LIBRARYS=(
  animation signal cursor colors stat
)

LIBRARY_PATH="${HOME}/.scripts/library"

for LIBRARY in ${LIBRARYS[@]}; do
  source ${LIBRARY_PATH}/${LIBRARY}.sh
done

FONTS_DIR="${HOME}/.fonts"

FONT_USED_PATH="${HOME}/.config/mytermux/fonts"
FONT_USED_FILE_NAME="used.log"
FONT_USED="$(cat ${FONT_USED_PATH}/${FONT_USED_FILE_NAME})"

TERMUX_CONFIGURATION_PATH="${HOME}/.termux"
TERMUX_CONFIGURATION_FONT_FILE_NAME="font.ttf"

function listFonts() {

  clear
  setCursor off

  gum style --border=rounded --border-foreground="5" --padding="1 2" --margin="1" \
    "🔤 Font Switcher" \
    "" \
    "Current: $FONT_USED"

  local choices=()
  local filenames=()

  for FONT in ${FONTS_DIR}/{*.ttf,*.otf}; do
    local name=$(echo ${FONT} | awk -F'/' '{print $NF}' | sed "s/.ttf//g" | sed "s/.otf//g")
    local filename=$(echo ${FONT} | awk -F'/' '{print $NF}')
    filenames+=("$filename")
    if [ "${FONT_USED}" == "${filename}" ]; then
      choices+=("$name ✓")
    else
      choices+=("$name")
    fi
  done

  local selected=$(gum choose "${choices[@]}")
  local index=0
  for choice in "${choices[@]}"; do
    if [ "$choice" == "$selected" ]; then
      local chosen_file="${filenames[$index]}"
      break
    fi
    index=$((index + 1))
  done

  if [ -z "$chosen_file" ]; then
    return
  fi

  gum spin --title "Applying font ..." -- \
    cp -fr "${FONTS_DIR}/${chosen_file}" "${TERMUX_CONFIGURATION_PATH}/${TERMUX_CONFIGURATION_FONT_FILE_NAME}"

  termux-reload-settings

  if [ ! -f ${FONT_USED_PATH}/${FONT_USED_FILE_NAME} ]; then
    echo "${chosen_file}" >> ${FONT_USED_PATH}/${FONT_USED_FILE_NAME}
  else
    sed -i "s/${FONT_USED}/${chosen_file}/g" ${FONT_USED_PATH}/${FONT_USED_FILE_NAME}
  fi

  stat "SUCCESS" "Success" "Font applied: $chosen_file"

}

function main() {

  trap 'handleInterruptByUser "Interrupt by User"' 2

  listFonts

}

main
