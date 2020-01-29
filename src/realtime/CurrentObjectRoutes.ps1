########################################################
##
## CurrentObjectRoutes.ps1
## Management interface to IQuipsys Positron
## Current object routes commands
##
#######################################################

function Get-IqsCurrentObjectRoutes
{
<#
.SYNOPSIS

Reads current routes for control objects service

.DESCRIPTION

Reads a page of routes from currobjectroutes service that satisfy specified criteria

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

Read-IqsCurrentObjectRoutes -OrgId 1 -Take 10

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
        $route = "/api/v1/organizations/{0}/curr_object_routes" -f $OrgId

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


function Get-IqsCurrentObjectRoute
{
<#
.SYNOPSIS

Gets current route by object id

.DESCRIPTION

Gets current route by route/object id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A route or object id

.EXAMPLE

Get-IqsCurrentObjectRoute -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/curr_object_routes/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route

        Write-Output $result
    }
    end {}
}

function Add-IqsCurrentObjectRoutePosition
{
<#
.SYNOPSIS

Adds position to current object route

.DESCRIPTION

Adds position to current object route

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Position

A position with the following structure:
- org_id: string
- object_id: string
- time: Date
- lat: number
- lng: number

.EXAMPLE

Add-IqsCurrentObjectRoutePosition -OrgId 1 -Position @{ org_id="1"; object_id="123"; lat=1; lng=1 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Position
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_object_routes/positions" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Position
        
        Write-Output $result
    }
    end {}
}


function Add-IqsCurrentObjectRoutePositions
{
<#
.SYNOPSIS

Adds multiple current object route positions

.DESCRIPTION

Adds several positions to current object routes

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Positions

A positions with the following structure:
- org_id: string
- object_id: string
- time: Date
- lat: number
- lng: number

.EXAMPLE

Add-IqsCurrentObjectRoutePositions -OrgId 1 -Positions @( @{ org_id="1"; object_id="123"; lat=1; lng=1 }, ... )

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object[]] $Positions
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/curr_object_routes/positions/batch" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Positions
        
        Write-Output $result
    }
    end {}
}
