targetScope = 'resourceGroup'

param commonName string
param location string

resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: 'asp-${commonName}'
  location: location
  sku: {
    name: 'B3'
    tier: 'Basic'
  }
}

resource webbApp 'Microsoft.Web/sites@2023-01-01' = {
  name: 'app${commonName}'
  location: location
  kind: 'webapp'
  identity: {
    type: 'SystemAssigned'
  }

  properties:{
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      netFrameworkVersion: 'v8.0'
      metadata: [
        {
          name: 'CURRENT_STACK'
          value: 'dotnet'
        }
      ]
    }
  }
}
