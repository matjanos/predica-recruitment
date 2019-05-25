# predica-recruitment

## Task 1

The task was to create a PowerShell script to automate the process of removing resources of the given types from a given resource group. It is presumed that the user of the script has permisions required to perform such operations and can provide Service Prinipal credentials.

### Preconditions

You need to have an AD application registered with role which allows to delete resources granted.
You also need to have certificate for Service Principal installed in order to use it's thumbprint to authenticate.

### Parameters

* **ResourceGroupName** - resource group in which resources are going to be removed
* **TenantId** - tenant ID for which 
* **CertThumbprint** - Thumbprint of the installed certificate for the automation service
* **ApplicationId** - AD application ID
* **Force** (*optional*) - to enforce deletion without asking (used for automated process)
* **ResourceTypesToRemove** (*optional*) - list of resource types. By default following are used: `Microsoft.Web/sites`, `Microsoft.Sql/servers`

## Task 2
[![Build Status](https://travis-ci.com/matjanos/predica-recruitment.svg?branch=master)](https://travis-ci.com/matjanos/predica-recruitment)

The task was to create a simple web API in ASP .NET Core which returns simple list of cars. As next step it should be build with Docker and pushed to a private Docker registry on Azure (Azure Container Registry). Finally, generated image is supposed to be automatically fetched by Azure Container Instances service and deployed to the cloud.

### Modus operandi

I've used dotnet CLI to generate a simple ASP Web API in .NET Core 2.1. I've done some simple changes: created a new model of `Car` and added `CarController`, which returns hardcoded list of 3 cars.

Next, I've created a `Dockerfile` which defines a Docker image: exposes ports, sets environment variables and prepare executables.

I've decided to use TravisCI in order to build the .NET project and the Docker image. `.travis-ci.yml` defines the build environment and all steps. All builds can be viewed here: https://travis-ci.com/matjanos/predica-recruitment

All build envinment variables are defined on TravisCI portal and describe connection details to Azure Container Registry on my private Azure subscription.

On the same subscription I've defined Azure Container Instances service which is eventually populated with the image created in the previous step.

### Result
`http://52.142.93.206/api/cars`
