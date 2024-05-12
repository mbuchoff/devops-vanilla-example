$subscriptionId = $(az account show --output tsv --query id)
$last4Sub = $subscriptionId.Substring($subscriptionId.Length -4)
$rgName = "rg-devopsvanillaexample-" + $last4Sub
$saName = "sadevopsvanillaexamp" + $last4Sub
az group create --name $rgName -l eastus
az storage account create --name $saName --resource-group $rgName --location eastus --sku Standard_LRS
az storage container create -n terraform --account-name $saName
