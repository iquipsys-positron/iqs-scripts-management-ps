########################################################
##
## Locations.ps1
## Management interface to IQuipsys Positron
## Locations commands
##
#######################################################


function Get-IqsLocations
{
<#
.SYNOPSIS

Gets page with locations by specified criteria

.DESCRIPTION

Gets a page with locations that satisfy specified criteria

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

Get-IqsLocations -OrgId 1 -Filter @{ search="gate" } -Take 10

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
        $route = "/api/v1/organizations/{0}/locations" -f $OrgId

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


function Get-IqsLocation
{
<#
.SYNOPSIS

Gets location by id

.DESCRIPTION

Gets location by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A location id

.EXAMPLE

Get-IqsLocation -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/locations/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsLocation
{
<#
.SYNOPSIS

Creates a new location

.DESCRIPTION

Creates a new location

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Location

A location with the following structure:
- id: string
- org_id: string
- name: string
- pos: any - GeoJSON

.EXAMPLE

New-IqsLocation -OrgId 1 -Location @{ org_id="1"; name="Main gate"; pos=@{ type="Point"; coordinates=@(32.11, -100.45) } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Location
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/locations" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Location
        
        Write-Output $result
    }
    end {}
}


function Update-IqsLocation
{
<#
.SYNOPSIS

Updates a location

.DESCRIPTION

Updates a location

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Location

A location with the following structure:
- id: string
- org_id: string
- name: string
- pos: any - GeoJSON

.EXAMPLE

Update-IqsLocation -OrgId 1 -Location @{ org_id="1"; name="Main gate"; pos=${ type="Point"; coordinates=@(32.11, -100.45) } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Location
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/locations/{1}" -f $OrgId, $Location.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Location
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsLocation
{
<#
.SYNOPSIS

Removes location by id

.DESCRIPTION

Removes location by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A location id

.EXAMPLE

Remove-IqsLocation -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/locations/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}