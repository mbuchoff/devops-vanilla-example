$subscriptionId = $(az account show --output tsv --query id)
$last4Sub = $subscriptionId.Substring($subscriptionId.Length -4)
$RESOURCE_GROUP_NAME = "rg-devopsvanillaexample-" + $last4Sub
$STORAGE_ACCOUNT_NAME = "sadevopsvanillaexamp" + $last4Sub
tofu init -backend-config="resource_group_name=$RESOURCE_GROUP_NAME" --backend-config="storage_account_name=$STORAGE_ACCOUNT_NAME"
