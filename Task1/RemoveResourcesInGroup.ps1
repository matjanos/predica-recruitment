# Task 1
# Recritment task - Predica
# Jakub Matjanowski
# 24/05/2019

<#

.SYNOPSIS
This is a simple Powershell script which removes given resources (by default Web apps and Azure SQL databases) for the given resource group.

.DESCRIPTION
The script looks for all resources of the given types in a given resource grup and removes them.

.EXAMPLE
./RemoveResourcesInGroup.ps1 -ResourceGroupName predica-rg -Force -TenantId xxxxxxx-xxxxx-xxxxxxxxx-xxxxx-xxxxxxxx -ApplicationId yyyyy-yyyyyy-yyyyyyy-yyyyy-yyyyy -CertThumbprint AAAAAAAAAAA66666987557AAA -ResourceTypesToRemove 'Microsoft.Web/sites','Microsoft.Storage/storageAccounts'

#>

Param(
    [Parameter(Mandatory= $True)]
    [String]
    $ResourceGroupName,

    [Parameter(Mandatory= $True)]
    [String]
    $TenantId,

    [Parameter(Mandatory= $True)]
    [String]
    $CertThumbprint,

    [Parameter(Mandatory= $True)]
    [String]
    $ApplicationId,

    [Parameter(Mandatory = $False)]
    [Switch]
    $Force,

    [Parameter(ValueFromRemainingArguments=$True)]
    [String[]]
    $ResourceTypesToRemove = ("Microsoft.Web/sites","Microsoft.Sql/servers")
)

Function Write-Log {
    [CmdletBinding()]
    Param(

    [Parameter(Mandatory=$True)]
    [string]
    $Message,

    [Parameter(Mandatory=$False)]
    [ValidateSet("INFO","WARN","ERROR","FATAL","DEBUG")] 
    [String]
    $Level = "INFO",

    [Parameter(Mandatory=$False)]
    [string]
    $logfile
    )

    $Stamp = (Get-Date).toString("yyyy/MM/dd HH:mm:ss")
    $Line = "$Stamp $Level $Message"
    if($logfile) {
        Add-Content $logfile -Value $Line
    }
    else {
        Write-Output $Line
    }
}

try
{
    Connect-AzAccount -ServicePrincipal -TenantId $TenantId -CertificateThumbprint $CertThumbprint -ApplicationId $ApplicationId
}
catch
{
    Write-Log "Unable to connect to the Azure Cloud: $_" -Level "ERROR"
    exit
}

Write-Log "Getting resources of types: $ResourceTypesToRemove to be removed in group $RemovedResourceGroupName"
$resourcesToRemove = @()
ForEach ($resourceType in $ResourceTypesToRemove)
{
    $resourcesToRemove += Get-AzureRmResource -ResourceType $resourceType -ResourceGroupName Predica | select -Property ResourceType,  Name, Id
}

if($resourcesToRemove.count -eq 0)
{
    Write-Log "No resources to be removed." -Level "WARN"
    exit
}

Write-Log "Removing resources..."

ForEach ($resource in $resourcesToRemove)
{
    try
    {
        Write-Log -Message "Removing $resource"
        Remove-AzureRmResource -ResourceId $resource.Id -Force:$Force.IsPresent
    }
    catch
    {
        Write-Log "Unable to remove resource $resource." -Level "ERROR"
        Write-Log $_
    }
}
