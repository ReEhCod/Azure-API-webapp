targetScope = 'subscription'

param commonName string
param location string

resource  rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name:'rg-${commonName}'
  location: location
}

module webbApp 'modules/webb-app.bicep' = {
  scope: rg
  name: commonName
  params:{
    commonName: commonName
    location: location
  }
}
