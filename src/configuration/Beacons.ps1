########################################################
##
## Beacons.ps1
## Management interface to IQuipsys Positron
## Beacons commands
##
#######################################################


function Get-IqsBeacons
{
<#
.SYNOPSIS

Gets page with beacons by specified criteria

.DESCRIPTION

Gets a page with beacons that satisfy specified criteria

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

Get-IqsBeacons -OrgId 1 -Take 10

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
        $route = "/api/v1/organizations/{0}/beacons" -f $OrgId

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


function Get-IqsBeacon
{
<#
.SYNOPSIS

Gets beacon by id

.DESCRIPTION

Gets beacon by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A beacon id

.EXAMPLE

Get-IqsBeacon -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/beacons/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function Find-IqsPositionByBeacon
{
<#
.SYNOPSIS

Calculate position by beacon udis

.DESCRIPTION

Calculate position by beacon udis

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER BeaconUdi

.EXAMPLE

Find-IqsPositionByBeacon -OrgId 1 -BeaconUdi 00000123, 00000124

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string[]] $BeaconUdi
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/beacons/calculate_position" -f $OrgId
        $params = @{
            org_id=$OrgId;
            udis=$BeaconUdi
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Params $params
        
        Write-Output $result
    }
    end {}
}


function New-IqsBeacon
{
<#
.SYNOPSIS

Creates a new beacon

.DESCRIPTION

Creates a new beacon

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Beacon

A beacon with the following structure:
- id: string
- org_id: string
- udi: string
- label: string
- center: any
- radius: number

.EXAMPLE

New-IqsBeacon -OrgId 1 -Beacon @{ org_id="1"; udi="0000123"; label="Parking"; center=@{ type="Point"; coordinates=@(32, -110) }; radius=50 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Beacon
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/beacons" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Beacon
        
        Write-Output $result
    }
    end {}
}


function Update-IqsBeacon
{
<#
.SYNOPSIS

Updates a new beacon

.DESCRIPTION

Updates a new beacon

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Beacon

A beacon with the following structure:
- id: string
- org_id: string
- udi: string
- label: string
- center: any
- radius: number

.EXAMPLE

Update-IqsBeacon -OrgId 1 -Beacon @{ org_id="1"; udi="0000123"; label="Parking"; center=@{ type="Point"; coordinates=@(32, -110) }; radius=50 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Beacon
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/beacons/{1}" -f $OrgId, $Beacon.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Beacon
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsBeacon
{
<#
.SYNOPSIS

Removes beacon by id

.DESCRIPTION

Removes beacon by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A beacon id

.EXAMPLE

Remove-IqsBeacon -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/beacons/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}
