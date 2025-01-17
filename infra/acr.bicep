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
  }
}

output registryId string = registry.outputs.resourceId
