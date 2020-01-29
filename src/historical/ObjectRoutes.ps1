########################################################
##
## ObjectRoutes.ps1
## Management interface to IQuipsys Positron
## Object routes commands
##
#######################################################


function Get-IqsObjectRoutes
{
<#
.SYNOPSIS

Gets page with object routes by specified criteria

.DESCRIPTION

Gets a page with object routes that satisfy specified criteria

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

Get-IqsObjectRoutes -OrgId 1 -Filter @{ search="gate" } -Take 10

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
        $route = "/api/v1/organizations/{0}/object_routes" -f $OrgId

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


function Get-IqsObjectRoute
{
<#
.SYNOPSIS

Gets object route by id

.DESCRIPTION

Gets object route by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

An object route id

.EXAMPLE

Get-IqsObjectRoute -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/object_routes/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsObjectRoute
{
<#
.SYNOPSIS

Creates a new object route

.DESCRIPTION

Creates a new object route

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Route

An object route with the following structure:
- id: string
- org_id: string
- object_id: string
- type: string
- start_time: Date
- start_addr?: AddressV1
  - line1: string
  - line2?: string
  - city: string
  - state: string
  - postal_code: string
  - country_code: string
- end_time: Date
- end_addr?: AddressV1
  - line1: string
  - line2?: string
  - city: string
  - state: string
  - postal_code: string
  - country_code: string
- duration: number
- positions: PositionV1[]
  - lat: number
  - lng: number

.EXAMPLE

New-IqsObjectRoute -OrgId 1 -Route @{ org_id="1"; object_id="1"; start_time=(Get-Date); end_time=(Get-Date); duration=0; positions=@(@{ lat=1; lng=1 }) } 

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Route
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_routes" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Route
        
        Write-Output $result
    }
    end {}
}


function Update-IqsObjectRoute
{
<#
.SYNOPSIS

Creates a new object route

.DESCRIPTION

Creates a new object route

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Route

An object route with the following structure:
- id: string
- org_id: string
- object_id: string
- type: string
- start_time: Date
- start_addr?: AddressV1
  - line1: string
  - line2?: string
  - city: string
  - state: string
  - postal_code: string
  - country_code: string
- end_time: Date
- end_addr?: AddressV1
  - line1: string
  - line2?: string
  - city: string
  - state: string
  - postal_code: string
  - country_code: string
- duration: number
- positions: PositionV1[]
  - lat: number
  - lng: number

.EXAMPLE

Update-IqsObjectRoute -OrgId 1 -Route @{ id="1"; org_id="1"; object_id="1"; start_time=(Get-Date); end_time=(Get-Date); duration=0; positions=@(@{ lat=1; lng=1 }) } 

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Route
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_routes/{1}" -f $OrgId, $Route.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Route
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsObjectRoute
{
<#
.SYNOPSIS

Removes object route by id

.DESCRIPTION

Removes object route by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A route id

.EXAMPLE

Remove-IqsObjectRoute -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/object_routes/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsObjectRoutes
{
<#
.SYNOPSIS

Removes object routes by filter

.DESCRIPTION

Removes object routes that match specified filter

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

# Delete positions for object 123
Remove-IqsObjectRoutes -OrgId 1 -Filter @{ object_id="123" }

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
        $route = "/api/v1/organizations/{0}/object_routes" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $Filter
        
        Write-Output $result
    }
    end {}
}