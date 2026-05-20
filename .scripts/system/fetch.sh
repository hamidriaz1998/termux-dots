#!/usr/bin/env bash

LIBRARYS=(
  colors signal stat
)

LIBRARY_PATH="${HOME}/.scripts/library"

for LIBRARY in ${LIBRARYS[@]}; do
  source ${LIBRARY_PATH}/${LIBRARY}.sh
done

function fetchStorage() {

  MOUNTED_ON="/storage/emulated"
  GREP_ONE_ROW=$(df -h | grep ${MOUNTED_ON})
  SIZE=$(echo ${GREP_ONE_ROW} | awk '{print $2}')
  USED=$(echo ${GREP_ONE_ROW} | awk '{print $3}')
  AVAIL=$(echo ${GREP_ONE_ROW} | awk '{print $4}')
  USE=$(echo ${GREP_ONE_ROW} | awk '{print $5}' | sed "s/%//g")
  MOUNTED=$(echo ${GREP_ONE_ROW} | awk '{print $6}')

  function execute() {

    gum style --border=rounded --border-foreground="4" --padding="0 1" \
      "💾 $MOUNTED" \
      "" \
      "Used: $USED / $SIZE" \
      "Available: $AVAIL" \
      "Usage: ${USE}%"

  }

  function help() {

    gum style --border=rounded --border-foreground="4" --padding="1 2" --margin="1" \
      "Usage: \`./fetch storage [option]\`" \
      "" \
      "-a  Show all output" \
      "-f  Show free space" \
      "-m  Show mounted path" \
      "-s  Show total size" \
      "-u  Show total used" \
      "-n  Show neofetch output" \
      "-p  Show percentage" \
      "-h  Print help"

  }

  case $1 in

    "" )
      stat "💾 $MOUNTED" "Warning" "$USED / $SIZE = $AVAIL (${USE}%)"
    ;;

    -a )
      echo "$USED / $SIZE = $AVAIL ($USE) > $MOUNTED"
    ;;

    -f )
      echo "$AVAIL"
    ;;

    -m )
      echo "$MOUNTED"
    ;;

    -n )
      execute
    ;;

    -s )
      echo "$SIZE"
    ;;

    -u )
      echo "$USED"
    ;;

    -p )
      echo "$USE"
    ;;

    -h )
      help
    ;;

    * )
      help
    ;;

  esac

}

function fetchBattery() {

  COMMAND="termux-battery-status"
  GET_BATTERY_PERCENTAGE=$(${COMMAND} 2>/dev/null | grep percentage | awk '{print $2}' | sed "s/,//g")
  GET_BATTERY_STATE=$(${COMMAND} 2>/dev/null | grep status | awk '{print $2}' | sed "s/,//g" | sed "s/\"//g")

  function checkingCommand() {

    if [ -x "$(command -v ${COMMAND})" ]; then

      ${1}

    else

      gum style --border=rounded --border-foreground="1" --padding="1 2" --margin="1" \
        "❌ Cannot Fetch Battery" \
        "" \
        "Command \`$COMMAND\` not found." \
        "Install Termux:API from F-Droid and run:" \
        "\`pkg install termux-api\`"

    fi

  }

  function executeFetch() {

    local icon=""
    local status=""

    if [ "${GET_BATTERY_STATE}" == "CHARGING" ]; then
      status="Charging"
    elif [ "${GET_BATTERY_STATE}" == "DISCHARGING" ]; then
      status="Discharging"
    elif [ "${GET_BATTERY_STATE}" == "FULL" ]; then
      status="Full"
    fi

    if [ ${GET_BATTERY_PERCENTAGE} -le 20 ]; then
      icon="🔴"
    elif [ ${GET_BATTERY_PERCENTAGE} -le 50 ]; then
      icon="🟡"
    else
      icon="🟢"
    fi

    gum style --border=rounded --border-foreground="4" --padding="0 1" \
      "$icon Battery — $status, ${GET_BATTERY_PERCENTAGE}%"

  }

  function help() {

    gum style --border=rounded --border-foreground="4" --padding="1 2" --margin="1" \
      "Usage: \`./fetch battery [option]\`" \
      "" \
      "percentage  Show battery percentage" \
      "state       Show charging state" \
      "help        Print help"

  }

  case ${1} in

    "" )
      checkingCommand executeFetch
    ;;

    percentage )
      echo "$GET_BATTERY_PERCENTAGE"
    ;;

    state )
      echo "$GET_BATTERY_STATE"
    ;;

    help )
      help
    ;;

    * )
      help
    ;;

  esac

}

function fetchHelp() {

  gum style --border=rounded --border-foreground="4" --padding="1 2" --margin="1" \
    "Usage: \`./fetch [option]\`" \
    "" \
    "battery   Fetch battery info" \
    "storage   Fetch storage info" \
    "help      Print help"

}

case ${1} in

  battery )
    fetchBattery ${2}
  ;;

  storage )
    fetchStorage ${2}
  ;;

  help )
    fetchHelp
  ;;

  * )
    fetchHelp
  ;;

esac
