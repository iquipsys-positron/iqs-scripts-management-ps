########################################################
##
## ObjectPositions.ps1
## Management interface to IQuipsys Positron
## ObjectPositions commands
##
#######################################################


function Get-IqsObjectPositions
{
<#
.SYNOPSIS

Gets page with positions by specified criteria

.DESCRIPTION

Gets a page with positions that satisfy specified criteria

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

Get-IqsObjectPositions -OrgId 1 -Filter @{ object_id="123" } -Take 10

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
        $route = "/api/v1/organizations/{0}/object_positions" -f $OrgId

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


function Add-IqsObjectPosition
{
<#
.SYNOPSIS

Adds position to object positions

.DESCRIPTION

Adds position to object positions

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

Add-IqsObjectPosition -OrgId 1 -Position @{ org_id="1"; object_id="123"; lat=1; lng=1 }

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
        $route = "/api/v1/organizations/{0}/object_positions" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Position
        
        Write-Output $result
    }
    end {}
}


function Add-IqsObjectPositions
{
<#
.SYNOPSIS

Adds multiple object positions

.DESCRIPTION

Adds several positions to object positions

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

Add-IqsObjectPositions -OrgId 1 -Positions @( @{ org_id="1"; object_id="123"; lat=1; lng=1 }, ... )

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
        $route = "/api/v1/organizations/{0}/object_positions/batch" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Positions
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsObjectPositions
{
<#
.SYNOPSIS

Removes positions by filter

.DESCRIPTION

Removes positions that match specified filter

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

# Delete positions for object 123
Remove-IqsObjectPositions -OrgId 1 -Filter @{ object_id="123" }

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
        $route = "/api/v1/organizations/{0}/object_positions" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $Filter
        
        Write-Output $result
    }
    end {}
}