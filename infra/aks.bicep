// The template to create an Azure Kubernetes Service

param name string = 'shopping-cluster'
param location string = resourceGroup().location
param osDiskSizeGB int = 0
param agentCount int = 3
param agentVMSize string = 'Standard_DS4_v2'
param tags object = {}
param logAnalyticsWorkspaceId string

module aks 'br/public:avm/res/container-service/managed-cluster:0.6.1' = {
	name: name
	params: {
		name: name
		location: location
		tags: tags
		publicNetworkAccess: 'Enabled'
		managedIdentities: {
			systemAssigned: true
		}
		enableRBAC: true
		aadProfile: {
			aadProfileEnableAzureRBAC: true
			aadProfileManaged: true
		}
		monitoringWorkspaceResourceId: logAnalyticsWorkspaceId
		primaryAgentPoolProfiles:	[
			{
				name: 'systempool'
				osDiskSizeGB: osDiskSizeGB
				count: agentCount
				vmSize: agentVMSize
				osType: 'Linux'
				mode: 'System'
				nodeTaints: [
					'CriticalAddonsOnly=true:NoSchedule'
				]
				enableAutoScaling: true
				minCount: 1
				maxCount: 3
				availabilityZones: [
					1,3
				]
			}
		]
		agentPools:	[
			{
				name: 'api'
				osDiskSizeGB: osDiskSizeGB
				enableAutoScaling: true
				count: agentCount
				vmSize: agentVMSize
				osType: 'Linux'
				mode: 'User'
				minCount: 1
				maxCount: 3
				nodeLabels: {
					app: 'shoppingapi'
				}
				availabilityZones: [
					1,3
				]
			}
			{
				name: 'client'
				osDiskSizeGB: osDiskSizeGB
				enableAutoScaling: true
				count: agentCount
				vmSize: agentVMSize
				osType: 'Linux'
				mode: 'User'
				minCount: 1
				maxCount: 3
				nodeLabels: {
					app: 'shoppingclient'
				}
				availabilityZones: [
					1,3
				]
			}
			{
				name: 'database'
				osDiskSizeGB: osDiskSizeGB
				enableAutoScaling: true
				count: agentCount
				vmSize: agentVMSize
				osType: 'Linux'
				mode: 'User'
				minCount: 1
				maxCount: 3
				nodeLabels: {
					app: 'mongodb'
				}
				availabilityZones: [
					1,3
				]
			}
		]
		diagnosticSettings: [
      {
        logCategoriesAndGroups: [
          {
            category: 'kube-apiserver'
          }
          {
            category: 'kube-controller-manager'
          }
          {
            category: 'kube-scheduler'
          }
          {
            category: 'cluster-autoscaler'
          }
        ]
        metricCategories: [
          {
            category: 'AllMetrics'
          }
        ]
        name: 'customSetting'
        workspaceResourceId: logAnalyticsWorkspaceId
      }
    ]

		roleAssignments: [
			{
				roleDefinitionIdOrName: 'Azure Kubernetes Service RBAC Cluster Admin'
				principalId: deployer().objectId
			}
		]
	}
}


output id string = aks.outputs.resourceId
output name string = aks.outputs.name
output identityId string = aks.outputs.systemAssignedMIPrincipalId?? '' // if null, return empty string
output requestUrl string = aks.outputs.controlPlaneFQDN
