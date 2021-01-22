#/bin/bash
#
#  This bash script modify all icons in a sub-directory
#  according to rules. 
# tixlegeek.io - @tixlegeek
#
dir="$1"

ESP82_ICON="./folder-teal-esp8266.svg"
ESP32_ICON="./folder-green-esp32.svg"
LRZK_ICON="./folder-red-private.svg"
CASH_ICON="./apps/gnucash-icon.svg"
GIT_ICON="./folder-cyan-git.svg"
SAVESH_ICON="./mintupload.svg"
PRJ_ICON="./folder-bluegrey-java.svg"
CLIENT_ICON="./godot.svg"
MAKEABLE_ICON="./text-x-makefile.svg"
function unseticon {
  gvfs-set-attribute $changefile -t unset  metadata::custom-icon
}
function seticon {
  # file icon_file
  changefile="$1"
  iconfile="$2"
  #gvfs-set-attribute -t string $changefile metadata::custom-icon file://$iconfile
  gio set "$changefile" metadata::custom-icon "file://$iconfile"
}

function setemblem {
  changefile="$1"
  iconfile="$2"
  echo "Changing emblem of $changefile to $iconfile"
  #gvfs-set-attribute -t stringv "$changefile" metadata::emblems "$iconfile"
  gio set "$changefile" metadata::custom-icon "file://$iconfile"
}

function makeableicon {
  dir="$1"
  if [ -f "$dir/Makefile" ]; then
    seticon "$dir" "$MAKEABLE_ICON"
  fi
}

function giticon {
  dir="$1"
  if [ -d "$dir/.git" ]; then
    seticon "$dir" "$GIT_ICON"
  fi
}

function gitemblem {
  dir="$1"
  if [ -d "$dir/.git" ]; then
    setemblem "$dir" "emblem-added"
    echo "$(gio info --attributes=metadata::custom-icon '$dir')"
  fi
}

pushd $dir
pwd
for i in *
do echo $i;
case $i in
  save.sh)
  echo $i"--> SAVESH BIZ"
  seticon "$i" "$SAVESH_ICON"
  ;;
  esp82*|ESP82*)
  echo $i"--> FLAG ESP"git
  seticon "$i" "$ESP82_ICON"
  gitemblem "$i"
  ;;
  esp32*|ESP32*)
  echo $i"--> FLAG ESP"git
  seticon "$i" "$ESP32_ICON"
  gitemblem "$i"
  ;;
  esp*|ESP*)
  echo $i"--> FLAG ESP"git
  seticon "$i" "$ESP82_ICON"
  gitemblem "$i"
  ;;
  lrzk*)
  echo $i"--> FLAG LRZK"
  seticon "$i" "$LRZK_ICON"
  gitemblem "$i"
  ;;
	PRJ*|PROJECT*)
  if [ -f "./$i/icon.svg" ]; then
    echo "CUSTOM ICON: $i/icon.svg"
    seticon "$i" $(realpath "./$i/icon.svg")
  else
	   seticon "$i" "$PRJ_ICON"
   fi
;;
	CLIENT*)
	seticon "$i" "$CLIENT_ICON"
;;
  BIZ_*)
  echo $i"--> FLAG BIZ"
  seticon "$i" "$CASH_ICON"
  ;;
  *)
  makeableicon "$i"

  gitemblem "$i"
  giticon "$i"
  ;;
esac
done
popd
