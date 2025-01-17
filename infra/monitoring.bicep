param workspaceName string = 'shoppingworkspace'
param location string


module logAnalyticsWorkspace 'br/public:avm/res/operational-insights/workspace:0.9.1' = {
  name: 'logAnalyticsWorkspace'
  params: {
    name: workspaceName
    location: location
  }
}

output workspaceId string = logAnalyticsWorkspace.outputs.resourceId
