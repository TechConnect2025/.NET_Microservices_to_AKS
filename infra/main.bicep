targetScope = 'subscription'

param location string = deployment().location
param environmentName string = 'dev'
param resourceGroupName string = 'rg-shopping'
param acrSku string = 'Standard'
param resourceToken string = toLower(uniqueString(subscription().id, location, resourceGroupName))
param aksShoppingclusterName string = 'shopping${resourceToken}'
param tags object = {
	environment: environmentName
}


// Deploy an Azure Resource Group

module resourceGroup 'br/public:avm/res/resources/resource-group:0.4.1' = {
	name: resourceGroupName
	params: {
		name: resourceGroupName
		location: location
		tags: tags
	}
}

// Deploy an Azure Log Analytics Workspace

module logAnalyticsWorkspace './monitoring.bicep' = {
	name: 'logAnalyticsWorkspace${resourceToken}'
	scope: az.resourceGroup(resourceGroupName)
	params: {
		workspaceName: 'shoppingworkspace${resourceToken}'
		location: location
	}
	dependsOn: [
		resourceGroup
	]
}

// Deploy an Azure Container Registry

module registry 'acr.bicep' = {
	name: 'registryDeployment'
	scope: az.resourceGroup(resourceGroupName)
	params: {
		name: 'shoppingregistry${resourceToken}'
		location: location
		sku: acrSku
	}
}

// Deploy an Azure Kubernetes Service

module aksShoppingClusterDeployment 'aks.bicep' = {
	name: 'aks-shoppingcluster-deployment'
	scope: az.resourceGroup(resourceGroupName)
	params: {
		location: location
		name: aksShoppingclusterName
		logAnalyticsWorkspaceId: logAnalyticsWorkspace.outputs.workspaceId
		tags: tags
	}
}



output aksShoppingClusterId string = aksShoppingClusterDeployment.outputs.id
output aksShoppingClusterName string = aksShoppingClusterDeployment.outputs.name
output acrId string = registry.outputs.registryId
output acrName string = registry.outputs.registryName
output resourceGroupName string = resourceGroup.outputs.name
output logAnalyticsWorkspaceId string = logAnalyticsWorkspace.outputs.workspaceId


