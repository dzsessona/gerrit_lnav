#!/usr/bin/env bash

cd "$(dirname "$0")"
SOURCE_FOLDER="$(pwd)/formats"
DESTINATION_FOLDER="${HOME}/.lnav/formats/installed"

# Ensure the destination folder exists
mkdir -p "$DESTINATION_FOLDER"

function install_formats() {
  for file in "$SOURCE_FOLDER"/*.json; do
    if [ -e "$file" ]; then
      echo "Adding format to lnav: $(basename $file)"
      ln -s "$file" "$DESTINATION_FOLDER/"
    fi
  done
}

function uninstall_formats() {
  for file in "$SOURCE_FOLDER"/*.json; do
    if [ -e "$file" ]; then
      if [ -L "$DESTINATION_FOLDER/$(basename $file)" ]; then
        echo "Removing format from lnav: $(basename $file)"
        rm "$DESTINATION_FOLDER/$(basename $file)" 
      fi
    fi
  done
}

function install_scripts() {
  for file in "$SOURCE_FOLDER"/*.lnav; do
    if [ -e "$file" ]; then
      echo "Adding script to lnav: $(basename $file)"
      ln -s "$file" "$DESTINATION_FOLDER/"
    fi
  done
}

function uninstall_scripts() {
  for file in "$SOURCE_FOLDER"/*.lnav; do
    if [ -e "$file" ]; then
      if [ -L "$DESTINATION_FOLDER/$(basename $file)" ]; then
        echo "Removing script from lnav: $(basename $file)"
        rm "$DESTINATION_FOLDER/$(basename $file)" 
      fi
    fi
  done
}

function show_help(){
    echo -e "\n\tUsage:   gerrit-lnav.sh operation"
    echo -e "\n\toperation:   one of the following "
    echo -e "\t\tinstall"
    echo -e "\t\tuninstall"
    echo -e "\t\tinstall_scripts"
    echo -e "\t\tinstall_formats"
    echo -e "\t\tuninstall_scripts"
    echo -e "\t\tuninstall_formats"
}

if [ -z "$1" ] || [ "$1" == "--help" ]; then
    show_help
else
    case $1 in
        install)
            install_scripts
            install_formats
            ;;
        uninstall)
            uninstall_scripts
            uninstall_formats
            ;;
        install_formats)
            install_formats
            ;;
        uninstall_formats)
            uninstall_formats
            ;;
        install_scripts)
            install_scripts
            ;;
        uninstall_scripts)
            uninstall_scripts
            ;;
        *)
            show_help
            ;;
    esac
fi
exit 0
