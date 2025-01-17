param name string 
param location string
param sku string

param resourceToken string = toLower(uniqueString(subscription().id, location))

module registry 'br/public:avm/res/container-registry/registry:0.7.0' = {
  name: 'registryDeployment${resourceToken}'
  params: {
    name: name
    acrSku: sku
    location: location
    acrAdminUserEnabled: true
  }
}

output registryId string = registry.outputs.resourceId
output registryName string = registry.outputs.name
output registryLoginServer string = registry.outputs.loginServer
