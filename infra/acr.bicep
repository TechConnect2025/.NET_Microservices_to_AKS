param name string 
param location string
param sku string
param aksIdentityId string
param resourceToken string = toLower(uniqueString(subscription().id, location))

module registry 'br/public:avm/res/container-registry/registry:0.7.0' = {
  name: 'registryDeployment${resourceToken}'
  params: {
    name: name
    acrSku: sku
    location: location
    acrAdminUserEnabled: true
    roleAssignments: [
      {
        roleDefinitionIdOrName: '7f951dda-4ed3-4680-a7ca-43fe172d538d'
        principalId: aksIdentityId
      }
    ]
  }
}

output registryId string = registry.outputs.resourceId
output registryName string = registry.outputs.name
output registryLoginServer string = registry.outputs.loginServer
