$subscriptionId = $(az account show --output tsv --query id)
$last4Sub = $subscriptionId.Substring($subscriptionId.Length -4)
$RESOURCE_GROUP_NAME = "rg-devopsvanillaexample-" + $last4Sub
$STORAGE_ACCOUNT_NAME = "sadevopsvanillaexamp" + $last4Sub
$Env:ARM_ACCESS_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
