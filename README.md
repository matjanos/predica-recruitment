# predica-recruitment

## Task 1
### Preconditions

You need to have an AD application registered with role which allows to delete resources:

You can do it in the following way:
```
 $servicePrincipal = New-AzADServicePrincipal -DisplayName "automatedResourceRemoval"
 New-AzRoleAssignment -RoleDefinitionName "Contributor" -ApplicationId $servicePrincipal.ApplicationId
```
