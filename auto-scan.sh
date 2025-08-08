#!/bin/bash

# the color convention
# Black        0;30     Dark Gray     1;30
# Red          0;31     Light Red     1;31
# Green        0;32     Light Green   1;32
# Brown/Orange 0;33     Yellow        1;33
# Blue         0;34     Light Blue    1;34
# Purple       0;35     Light Purple  1;35
# Cyan         0;36     Light Cyan    1;36
# Light Gray   0;37     White         1;37

RED='\033[1;31m'
ORANGE='\033[1;33m'
CYAN='\033[1;36m'
RST='\033[0m'
WHITE_BG='\033[1;30;47m'

banner() {
  MADE_BY="made by <zakaria-with-glasses>"

  echo "                (_)"
  echo "              <--|-->"
  echo "             _   |   _              ${MADE_BY}"
  echo "             \\__/ \\__/"
  echo "              '-. .-'"
  echo "                 '"
}

info(){
    echo -e "${WHITE_BG} INFO ${RST} $1";
}
warn(){
    echo -e "${WHITE_BG} WARNING ${RST}${ORANGE} $1${RST}";
}

error(){
    echo -e "${WHITE_BG} ERROR ${RST}${RED} $1${RST}";
}


scan(){
    # essentially what will happen here is that the function will execute nmap
    # with all the usual flags and output it in this file <IP>.txt

    # nmap flags needed:
    
    # -oN <output>.fmt -- to save output
    # -sV -- for service detection
    # -sS -- for the usual SYN SCAN
    # -sO -- for protocol scan
    #
    info "Scanning Host"
    nmap -sV -sS -oN $1 $2 > /dev/null
}

ping(){
    ping  $1
}


echo "argument number: $#"

## main ##

banner
if (( $EUID != 0))
    then error "RUN THIS SCRIPT USING SUDO!"
    exit
fi


if (( $# < 1)) then
    echo "Usage: auto-scan.sh arg1 arg2 ..."
    exit 1
fi

case "$1" in
    scan)
        scan $2 $3 # i should provide them in this order: outputfile ip/hostname
        ;;

    *)
        ping "$1"
        ;;
esac
