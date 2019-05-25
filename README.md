# predica-recruitment

## Task 1

The task was to create a PowerShell script to automate the process of removing resources of the given type from a given resource group. It is presumed that the user of the script has permisions required to perform such operations and can provide Service Prinipal credentials.

### Preconditions

You need to have an AD application registered with role which allows to delete resources granted.
You also need to have certificate for Service Principal installed in order to use it's thumbprint to authentication.

### Parameters

* **ResourceGroupName** - resource group in which resources are going to be removed
* **TenantId** - tenant ID for which 
* **CertThumbprint** - Thumbprint of the installed certificate for the automation service
* **ApplicationId** - AD application ID
* **Force** (*optional*) - to enforce deletion without asking (used for automated process)
* **ResourceTypesToRemove** (*optional*) - list of resource types. By default following are used: `Microsoft.Web/sites`, `Microsoft.Sql/servers`
