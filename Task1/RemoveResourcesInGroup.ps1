# Task 1
# Recritment task - Predica
# Jakub Matjanowski
# 24/05/2019

<#

.SYNOPSIS
This is a simple Powershell script which removes given resources (by default Web apps and Azure SQL databases) for the given resource group.

.DESCRIPTION
The script looks for all resources of the given types in a fiven resource grup and removes them.

.EXAMPLE
./RemoveResourcesInGroup.ps1 -ResourceGroupName predica-rg -Force -ResourceTypesToRemove 'Microsoft.Web/sites','Microsoft.Storage/storageAccounts'

#>

Param(
    [Parameter(Mandatory = $True)]
    [String]
    $ResourceGroupName,

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
    If($logfile) {
        Add-Content $logfile -Value $Line
    }
    Else {
        Write-Output $Line
    }
}

#Connect-AzAccount

Write-Log "Getting resources of types: $ResourceTypesToRemove to be removed in group $RemovedResourceGroupName"
$resourcesToRemove = @()
ForEach ($resourceType in $ResourceTypesToRemove){
    $resourcesToRemove += Get-AzureRmResource -ResourceType $resourceType -ResourceGroupName Predica | select -Property ResourceType,  Name, Id
}

Write-Log "Removing..."

ForEach ($resource in $resourcesToRemove){
    try{
        Write-Log -Message "Removing $resource"
        Remove-AzureRmResource -ResourceId $resource.Id -Force:$Force.IsPresent
    }
    catch{
        Write-Log "Unable to remove resource $resource." -Level "ERROR"
        Write-Log $_
    }
}
