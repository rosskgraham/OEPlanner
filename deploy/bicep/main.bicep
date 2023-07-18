targetScope = 'subscription'

@minLength(1)
param rgName string

@minLength(1)
param location string = deployment().location

@minLength(1)  
param appServicePlanName string

@minLength(1)  
param uiAppServiceName string
@minLength(1)  
param workerAppServiceName string
@minLength(1)  
param apiAppServiceName string

@minLength(1)
param appInsightsName string 

@minLength(1)  
param logAnalyticsName string

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: rgName
  location: location
}


module resourcesModule 'resources.bicep' = {
  name: 'resourcesDeployment'
  scope: resourceGroup(rg.name)
  params: {
    location: location
    uiAppServiceName: uiAppServiceName 
    workerAppServiceName: workerAppServiceName
    apiAppServiceName:apiAppServiceName
    appInsightsName: appInsightsName
    logAnalyticsName: logAnalyticsName
    appServicePlanName : appServicePlanName
  }
}
