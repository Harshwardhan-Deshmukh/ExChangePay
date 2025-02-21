# Execute this script for setting up the AZURE DEVOPS -> AZURE Connection for Pipelines to Authenticate
RESOURCE_GROUP_NAME="azure-devops-user-rg"
AZURE_DEVOPS_USER="azure-devops-user-mi"
TERRAFORM_BACKEND_STORAGE_ACCOUNT="satfstateecpeus01" # change this name as storage account should be globally unique

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
