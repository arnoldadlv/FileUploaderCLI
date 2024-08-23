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


#Azure API Call
read -p "Enter your Azure tenants subscription ID: " subscriptionID
azAPIUrl="https://management.azure.com/subscriptions/${subscriptionID}/providers/Microsoft.Storage/checkNameAvailability?api-version=2023-05-01"

dFlag=$(cat <<EOF
{
    "name": "$storageAccountName",
    "type": "Microsoft.Storage/storageAccounts"
}
EOF
)

accessToken=$(az account get-access-token --query accessToken --output tsv)

jsonResponse=$(curl --request POST "$azAPIUrl" \
-H "Authorization: Bearer $accessToken" \
-H "Content-Type: application/json" \
-d "$dFlag")

nameAvailable=$(echo $jsonResponse | jq '.nameAvailable')

if [ $nameAvailable == 'true' ] 
then
    echo "Error: The storage account does not exist."
    exit 1
else
    #logs user into az 
az login
az storage blob upload --account-name $storageAccountName --container-name $containerName --file $fileName --verbose
fi

