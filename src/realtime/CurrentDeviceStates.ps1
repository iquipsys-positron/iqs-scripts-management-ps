########################################################
##
## CurrentDeviceStates.ps1
## Management interface to IQuipsys Positron
## Current device states commands
##
#######################################################

function Get-IqsCurrentDeviceStates
{
<#
.SYNOPSIS

Reads current states for tracker devices service

.DESCRIPTION

Reads a page of states from currdevicestates service that satisfy specified criteria

.PARAMETER Connection

A connection device

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Read-IqsCurrentDeviceStates -OrgId 1 -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_device_states" -f $OrgId

        $params = $Filter +
        @{ 
            skip = $Skip;
            take = $Take
            total = $Total
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route -Params $params

        Write-Output $result.Data
    }
    end {}
}


function Get-IqsCurrentDeviceState
{
<#
.SYNOPSIS

Gets current state by device id

.DESCRIPTION

Gets current state by state/device id

.PARAMETER Connection

A connection device

.PARAMETER OrgId

A organization id

.PARAMETER Id

A state or device id

.EXAMPLE

Get-IqsCurrentDeviceState -OrgId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_device_states/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route

        Write-Output $result
    }
    end {}
}


function Set-IqsCurrentDeviceState
{
<#
.SYNOPSIS

Sets current state of specified device

.DESCRIPTION

Sets current state for control device device

.PARAMETER Connection

A connection device

.PARAMETER OrgId

A organization id

.PARAMETER State

A current device state with the following structure
- id: string
- org_id: string
- object_id: string
- time: Date
- pos: any // GeoJSON
- alt: number
- angle: number
- speed: number

.EXAMPLE

Set-IqsCurrentDeviceState -OrgId 1 -State @{ org_id="1"; object_id="1"; time=$(Get-Date)  }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $State
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_device_states/{1}" -f $OrgId, $State.device_id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $State
        
        Write-Output $result
    }
    end {}
}

function Remove-IqsCurrentDeviceState
{
<#
.SYNOPSIS

Removes current state by device id

.DESCRIPTION

Removes current state by state/device id

.PARAMETER Connection

A connection device

.PARAMETER OrgId

A organization id

.PARAMETER Id

A state or device id

.EXAMPLE

Remove-IqsCurrentDeviceState -OrgId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_device_states/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route

        Write-Output $result
    }
    end {}
}


function Remove-IqsCurrentDeviceStates
{
<#
.SYNOPSIS

Removes current states for control devices service

.DESCRIPTION

Removes states from currdevicestates service that satisfy specified criteria

.PARAMETER Connection

A connection device

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Remove-IqsCurrentDeviceStates -OrgId 1

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{}
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_device_states" -f $OrgId
        $params = $Filter

        $null = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $params
    }
    end {}
}
