targetScope = 'subscription'

@minLength(1)
param rgName string

@minLength(1)
param location string = deployment().location

@minLength(1)  
param appName string


resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}


module resourcesModule 'resources.bicep' = {
  name: 'resourcesDeployment'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    appName: appName
  }
}
