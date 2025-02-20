# Execute this Script to Decommision the Resource Group for Azure Devop

RESOURCE_GROUP_NAME="azure-devops-user-rg"

az group delete --resource-group $RESOURCE_GROUP_NAME -y