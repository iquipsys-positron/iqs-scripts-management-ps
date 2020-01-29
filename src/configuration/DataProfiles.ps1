########################################################
##
## DataProfiles.ps1
## Management interface to IQuipsys Positron
## DataProfiles commands
##
#######################################################

function Get-IqsDataProfile
{
<#
.SYNOPSIS

Gets data profile by organization id

.DESCRIPTION

Gets data profile by organization id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.EXAMPLE

Get-IqsDataProfile -OrgId 1

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/data_profiles" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function Set-IqsDataProfile
{
<#
.SYNOPSIS

Sets a data profile

.DESCRIPTION

Sets a data profile

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Profile

A data profile with the following structure:
- id: string
- param_types: SensorParameterType[]
- event_types: SensorEventType[]
- command_types: ActuatorCommandType[]
- state_types: SensorStateType[]

.EXAMPLE

Set-IqsDataProfile -OrgId 1 -Profile @{ param_types=@( @{ id=100; name="Param 1"; algorithm="custom" } ) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Profile
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/data_profiles" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Profile
        
        Write-Output $result
    }
    end {}
}
