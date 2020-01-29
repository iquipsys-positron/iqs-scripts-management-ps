########################################################
##
## Organizations.ps1
## Management interface to IQuipsys Positron
## Organizations commands
##
#######################################################


function Get-IqsOrganizations
{
<#
.SYNOPSIS

Gets page with organizations by specified criteria

.DESCRIPTION

Gets a page with organizations that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsOrganizations -Filter @{ ids=@("1", "2") } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations"

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


function Get-IqsOrganization
{
<#
.SYNOPSIS

Gets organization by id

.DESCRIPTION

Gets organization by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A organization id

.EXAMPLE

Get-IqsOrganization -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}" -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsOrganization
{
<#
.SYNOPSIS

Creates a new organization

.DESCRIPTION

Creates a new organization

.PARAMETER Connection

A connection object

.PARAMETER Organization

A organization with the following structure:
- id: string
- code: string
- active: boolean
- name: string
- description: string
- address: string
- center: any - GeoJSON
- radius?: number - In km
- geometry: any - GeoJSON
- map_id: string - Blob id with map background
- map_north: number
- map_south: number
- map_west: number
- map_east: number

.EXAMPLE

New-IqsOrganization -Organization @{ code="COOL123"; name="Cool mine"; active=$true }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Organization
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations"

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Organization
        
        Write-Output $result
    }
    end {}
}


function Update-IqsOrganization
{
<#
.SYNOPSIS

Updates a organization

.DESCRIPTION

Updates a organization

.PARAMETER Connection

A connection object

.PARAMETER Organization

A organization with the following structure:
- id: string
- code: string
- active: boolean
- name: string
- description: string
- address: string
- center: any - GeoJSON
- radius?: number - In km
- geometry: any - GeoJSON
- map_id: string - Blob id with map background
- map_north: number
- map_south: number
- map_west: number
- map_east: number

.EXAMPLE

Update-IqsOrganization -Organization @{ code="COOL123"; name="Cool mine"; active=$true }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Organization
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}" -f $Organization.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Organization
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsOrganization
{
<#
.SYNOPSIS

Removes organization by id

.DESCRIPTION

Removes organization by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A organization id

.EXAMPLE

Remove-IqsOrganization -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}" -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}


function Get-IqsOrganizationUsers
{
<#
.SYNOPSIS

Gets page with organization users by organization id

.DESCRIPTION

Gets a page with organization users by organization id

.PARAMETER Connection

A connection object

.PARAMETER Id

A organization id

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsOrganizationUsers -Id 123 -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = "/api/v1/organization_users"

        $params = @{ 
            org_id = $Id;
            skip = $Skip;
            take = $Take
            total = $Total
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route -Params $params

        Write-Output $result.Data
    }
    end {}
}