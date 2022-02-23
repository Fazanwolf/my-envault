#!/bin/bash

source .installUbuntu.sh
source .installFedora.sh

engine=none

getOS()
{
    OS=$(uname -a)
    case "${OS}" in
        *Ubuntu*) engine=Ubuntu;;
        *Fedora*) engine=Fedora;;
        Darwin*) engine=Mac;;
    esac
}

checkInstalled()
{
    $1
    if [[ $? -eq 127 ]]; then
        return -1;
    fi
    return 0;
}

installPhp()
{
    tmp=$(checkInstalled "php --version")
    if [[ $? -eq -1 ]]; then
        [ "$engine" == "Ubuntu" ] && phpUbuntu || [ "$engine" == "Fedora" ] && phpFedora || [ "$engine" == "Mac" ] && phpMac || echo ":)"
    fi
    phpVersion=$(php --version | grep "^PHP " | cut -d' ' -f2)
    fst=$(echo $phpVersion | cut -d'.' -f1)
    scd=$(echo $phpVersion | cut -d'.' -f2)
    if [ $fst -ge 7 ] && [ $scd -ge 4 ]; then
        return 0;
    elif [ $fst -ge 8 ] && [ $scd -ge 0 ]; then
        return 0;
    else
        echo "Update your php to 7.4 minimum."
        exit
    fi
}

installComposer()
{
    tmp=$(checkInstalled "composer --version")
    if [ $? == -1 ]; then
        [ "$engine" == "Ubuntu" ] && composerUbuntu || [ "$engine" == "Fedora" ] && composerFedora || [ "$engine" == "Mac" ] && composerMac || echo "Oupsi.. Error in: installComposer Type: OS not found"
    fi
}

installHeroku()
{
    tmp=$(checkInstalled "heroku --version")
    if [ $? == -1 ]; then
        [ "$engine" == "Ubuntu" ] && herokuUbuntu || [ "$engine" == "Fedora" ] && herokuFedora || [ "$engine" == "Mac" ] && herokuMac || echo "Oupsi.. Error in: installHeroku Type: OS not found"
    fi
}

installGit()
{
    tmp=$(checkInstalled "git --version")
    if [ $? == -1 ]; then
        [ "$engine" == "Ubuntu" ] && herokuUbuntu || [ "$engine" == "Fedora" ] && herokuFedora || [ "$engine" == "Mac" ] && herokuMac || echo "Oupsi.. Error in: installGit Type: OS not found"
    fi
}

checkRequirement()
{
    installPhp
    installComposer
    installHeroku
    installGit
}
