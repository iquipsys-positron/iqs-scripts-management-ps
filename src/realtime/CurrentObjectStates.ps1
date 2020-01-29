########################################################
##
## CurrentObjectStates.ps1
## Management interface to IQuipsys Positron
## Current object states commands
##
#######################################################

function Get-IqsCurrentObjectStates
{
<#
.SYNOPSIS

Reads current states for control objects service

.DESCRIPTION

Reads a page of states from currobjectstates service that satisfy specified criteria

.PARAMETER Connection

A connection object

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

Read-IqsCurrentObjectStates -OrgId 1 -Take 10

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
        $route = "/api/v1/organizations/{0}/curr_object_states" -f $OrgId

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


function Get-IqsCurrentObjectState
{
<#
.SYNOPSIS

Gets current state by object id

.DESCRIPTION

Gets current state by state/object id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A state or object id

.EXAMPLE

Get-IqsCurrentObjectState -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/curr_object_states/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route

        Write-Output $result
    }
    end {}
}


function Set-IqsCurrentObjectState
{
<#
.SYNOPSIS

Sets current state of specified object

.DESCRIPTION

Sets current state for control object object

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER State

A current object state with the following structure
- id: string
- org_id: string
- device_id: string
- assigned_id: string
- online: number
- immobile: number
- time: Date
- pos: any // GeoJSON
- alt: number
- angle: number
- speed: number

.EXAMPLE

Set-IqsCurrentObjectState -OrgId 1 -State @{ org_id="1"; device_id="1"; time=$(Get-Date); immobile=0; emergency=0  }

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
        $route = "/api/v1/organizations/{0}/curr_object_states/{1}" -f $OrgId, $State.device_id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $State
        
        Write-Output $result
    }
    end {}
}


function Update-IqsCurrentObjectState
{
<#
.SYNOPSIS

Updates current state of specified object

.DESCRIPTION

Changes current state, calculates all rules, generates events and logs historical records

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER State

A state update with the following structure
- org_id: string
- device_id: string
- immobile: boolean
- time: Date
- lat: number
- lng: number
- alt: number
- angle: number
- speed: number

.EXAMPLE

Update-IqsCurrentObjectState -OrgId 1 -State @{ org_id="1"; device_id="1"; time=$(Get-Date); immobile=$false; emergency=$false  }

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
        $route = "/api/v1/organizations/{0}/state_updates" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $State
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsCurrentObjectState
{
<#
.SYNOPSIS

Removes current state by object id

.DESCRIPTION

Removes current state by state/object id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A state or object id

.EXAMPLE

Remove-IqsCurrentObjectState -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/curr_object_states/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route

        Write-Output $result
    }
    end {}
}


function Remove-IqsCurrentObjectStates
{
<#
.SYNOPSIS

Removes current states for control objects service

.DESCRIPTION

Removes states from currobjectstates service that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Remove-IqsCurrentObjectStates -OrgId 1

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
        $route = "/api/v1/organizations/{0}/curr_object_states" -f $OrgId
        $params = $Filter

        $null = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $params
    }
    end {}
}


function Send-IqsObjectStateUpdate
{
<#
.SYNOPSIS

Updates current state of specified object asynchronously

.DESCRIPTION

Initiate update of the current state, calculates all rules, generates events and logs historical records

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER State

A state update with the following structure
- org_id: string
- device_id: string
- immobile: boolean
- time: Date
- lat: number
- lng: number
- alt: number
- angle: number
- speed: number

.EXAMPLE

Send-IqsObjectStateUpdate -OrgId 1 -State @{ org_id="1"; device_id="1"; time=$(Get-Date); immobile=$false; emergency=$false  }

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
        $route = "/api/v1/organizations/{0}/begin_update_state" -f $OrgId

        Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $State
    }
    end {}
}
