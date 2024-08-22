#!/bin/bash

verifyazCli=$(command -v az) 
installedVerify=$(echo $?)

#echo $installedVerify

if [ $installedVerify == 0 ]
then
    :
    #echo "You have az cli installed."
else
    echo "Install az cli."
fi

az login

read -p "Enter your filepath: " filePath
##filePath=$1

if [ -z $filePath ]
then
    echo "Please enter a file you want to upload"
else
    if [ -f "$filePath" ]
        then
            echo "This exists"

        else
            echo "This file does not exist"
        fi
fi

read -p "Enter the name of your storage account: " storageAccountName

read -p "Enter the name of a container in your storage account: " containerName

az storage blob upload --account-name $storageAccountName --container-name $containerName --file $filePath --verbose

#if [ storageAccountName ]
#then
#    az storage blob upload --account-name $storageAccountName --container-name $containerName --file $filePath
#fi