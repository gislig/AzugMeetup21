# Script created by Gí­sli Guðmundsson
# For Azug Meetup Iceland - 19.02.2021

#https://developer.microsoft.com/en-us/graph/graph-explorer

function Get-GraphData($ApplicationID, $TenantID, $AccessSecret, $GraphUrl){
    $Body = @{    
        Grant_Type    = "client_credentials"
        Scope         = "https://graph.microsoft.com/.default"
        client_Id     = $ApplicationID
        Client_Secret = $AccessSecret
    } 

    $ConnectGraph = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$TenantID/oauth2/v2.0/token" -Method POST -Body $Body

    $Headers = @{
        'Authorization' = "Bearer $($ConnectGraph.access_token)"
    }
    
    $GraphResult = (Invoke-RestMethod -Uri $GraphUrl -Headers $Headers).Value
    return $GraphResult
}

$ApplicationID = Get-Content .\ApplicationID.txt
$TenantID = Get-Content .\TenantID.txt
$AccessSecret = Get-Content .\AccessSecret.txt

$Temp = 'https://graph.microsoft.com/v1.0/auditLogs/directoryAudits'


$group = Get-GraphData -ApplicationID $ApplicationID -TenantID $TenantID -AccessSecret $AccessSecret -GraphUrl $Temp | ? { $_.activityDisplayName -eq "Add member to group" }

$userModified = $group.targetResources.userPrincipalName -replace " ",""
$groupModified = ($group.targetResources.modifiedProperties | ? { $_.displayName -eq "Group.DisplayName" }).newValue -replace '"',""

$group
