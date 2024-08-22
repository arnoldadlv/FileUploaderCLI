#!/bin/bash

fileName=""
storageAccountName=""
containerName=""

#Checks for argument usage
for i in "$@"; do
    case "$i" in
        "--help")
        echo "Usage: upload.sh [options...]"
        echo "--help                  Get help for commands"
        echo "--file-name [name]      Specify the file to upload"
        echo "--storage-account [name] Specify the Azure storage account"
        exit 0
        shift
        ;;

        "--file-name")
        shift
        fileName=$1
        shift
        if [ -z $fileName ]
        then
            read -p "Please enter the name of the file you wish to upload: " fileName        
        fi
        ;;

        "--storage-account")
        shift
        storageAccountName=$1
        shift
        if [ -z $storageAccountName ]
        then   
            read -p "Please enter the name of your storage account: " storageAccountName
        fi
        ;;

        "--container")
        shift
        containerName=$1
        shift
        if [ -z $containerName ]
        then
            read -p "Please enter the name of the container in your storage account: " containerName
        fi
        ;;
    esac
done

#Checks if any of the variables are empty, if they are, it prompts the user to fill it out
if [ -z "$fileName" ]
then
    read -p "Please enter the name of the file you wish to upload: " fileName
fi

if [ -z "$storageAccountName" ]
then
    read -p "Please enter the name of the storage account you wish to upload to: " storageAccountName
fi

if [ -z "$containerName" ]
then
    read -p "Please enter the name of the container you wish to upload to: " containerName
fi

if [ -f $fileName ]; then 
    :
else
    echo "Error: The file '$fileName' does not exist"
    exit 1
fi


echo "Name of file to upload: ${fileName}"
echo "Name of storage account: ${storageAccountName}"
echo "Name of container: ${containerName}"

az login
az storage blob upload --account-name $storageAccountName --container-name $containerName --file $fileName --verbose
