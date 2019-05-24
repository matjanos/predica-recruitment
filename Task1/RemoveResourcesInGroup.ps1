# Task 1
# Recritment task - Predica
# Jakub Matjanowski
# 24/05/2019

Param(
    [Parameter(Mandatory = $true,ParameterSetName = "ResourceGroupName")]
    [String]
    $ResourceGroupName,

    [Parameter(Mandatory = $false, ParameterSetName = "ResourceTypesToRemove")]
    [String[]]
    $ResourceTypesToRemove = ("Microsoft.Web/sites","Microsoft.Sql/servers"),

    [Parameter(Mandatory = $false, ParameterSetName = "Confirmed")]
    [Boolean]
    $Confirmed = $false
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

Write-Log "Getting resources to be removed in group $RemovedResourceGroupName"
$resourcesToRemove = @()
ForEach ($resourceType in $ResourceTypesToRemove){
    $resourcesToRemove += Get-AzureRmResource -ResourceType $resourceType -ResourceGroupName Predica | select -Property ResourceType,  Name, Id
}

Write-Log  $resourcesToRemove

Write-Log "Removing..."


ForEach ($resource in $resourcesToRemove){
    try{
        Write-Log -Message "Removing $resource"
        Remove-AzureRmResource -ResourceId $resource.Id -Confirmed $Confirmed
    }
    catch{
        Write-Log "Unable to remove resource $resource." -Level "ERROR"
    }
}
