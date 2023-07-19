targetScope = 'resourceGroup'

param location string

param uiAppServiceName string
param workerAppServiceName string
param apiAppServiceName string


param appInsightsName string  
param logAnalyticsName string

@minLength(1)
param appServicePlanName string

resource appServicePlan 'Microsoft.Web/serverfarms@2021-03-01' = {
  name: appServicePlanName
  location: location
  kind: 'linux'
  properties: {
    reserved: true
  }
  sku: {
    name: 'B1'
    capacity: 1
  }
}


resource appInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: appInsightsName
  location: location
  kind: 'web' 
  properties: {
     Application_Type: 'web'
     WorkspaceResourceId: logAnalytics.id
  }
}

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2021-12-01-preview' = {
  name: logAnalyticsName
  location: location
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    workspaceCapping: {
      dailyQuotaGb: 1
    }
  }
}

resource uiAppService 'Microsoft.Web/sites@2021-03-01' = {
  name: uiAppServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.ConnectionString
        }
      ] 
    }
  }
}

resource workerAppService 'Microsoft.Web/sites@2021-03-01' = {
  name: workerAppServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.10'
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.ConnectionString
        }
      ] 
    }
  }
}


resource apiAppService 'Microsoft.Web/sites@2021-03-01' = {
  name: apiAppServiceName
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    siteConfig: {
      linuxFxVersion: 'PYTHON|3.10'
      appSettings: [
        {
          name: 'APPINSIGHTS_INSTRUMENTATIONKEY'
          value: appInsights.properties.ConnectionString
        }
      ] 
    }
  }
}

