# Execute this script for setting up the AZURE DEVOPS -> AZURE Connection for Pipelines to Authenticate
RESOURCE_GROUP_NAME="azure-devops-user-rg"
AZURE_DEVOPS_USER="azure-devops-user-mi"
TERRAFORM_BACKEND_STORAGE_ACCOUNT="satfstateecpeus01" # change this name as storage account should be globally unique
CONTAINER_NAME="exchangepay-tfstate"

# Create a Resource Group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create a User Assigned Managed Identity
az identity create --name $AZURE_DEVOPS_USER --resource-group $RESOURCE_GROUP_NAME 

# Get the Client Id of the Managed Identity for Role Assignment
CLIENT_ID=$(az identity show --name $AZURE_DEVOPS_USER --resource-group $RESOURCE_GROUP_NAME  --query clientId --output tsv)

# Get the Subscription ID for Role Assignment
SUBSCRIPTION_ID=$(az identity show --name $AZURE_DEVOPS_USER --resource-group $RESOURCE_GROUP_NAME  --query subscriptionId --output tsv)

# Assign Contributor Role to the Managed Identity which will be used by Azure DevOps Pipeline to Create Resources in this Subscription
az role assignment create --assignee $CLIENT_ID --role "Contributor" --scope /subscriptions/$SUBSCRIPTION_ID

# Create a Storage Account and Blob Container inside it for Terraform to Store its State file
az storage account create --name $TERRAFORM_BACKEND_STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP_NAME --sku "Standard_LRS" --encryption-services "blob" --public-network-access "Enabled" 1> /dev/null
az storage account blob-service-properties update --resource-group $RESOURCE_GROUP_NAME --account-name $TERRAFORM_BACKEND_STORAGE_ACCOUNT --enable-versioning "true" --enable-delete-retention "true" --delete-retention-days "7" --enable-container-delete-retention "true" --container-delete-retention-days "7" 1> /dev/null
az storage container create --name $CONTAINER_NAME --account-name $TERRAFORM_BACKEND_STORAGE_ACCOUNT --resource-group $RESOURCE_GROUP_NAME --auth-mode login

# Fetch the Storage Account ID for Role Assignment
STORAGE_ACCOUNT_ID=$(az storage account show --name satfstateecpeus01 --resource-group azure-devops-user-rg --query id --output tsv)

# Assign Storage Blob Data Contributor role to the Managed Identity allowing it to makeblob  related changes in the Storage Container
az role assignment create --assignee $CLIENT_ID --role "Storage Blob Data Contributor" --scope $STORAGE_ACCOUNT_ID