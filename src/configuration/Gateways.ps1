########################################################
##
## Gateways.ps1
## Management interface to IQuipsys Positron
## Gateways commands
##
#######################################################


function Get-IqsGateways
{
<#
.SYNOPSIS

Gets page with gateways by specified criteria

.DESCRIPTION

Gets a page with gateways that satisfy specified criteria

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

Get-IqsGateways -OrgId 1 -Filter @{ udi="23433455" } -Take 10

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
        $route = "/api/v1/organizations/{0}/gateways" -f $OrgId

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


function Get-IqsGateway
{
<#
.SYNOPSIS

Gets gateway by id

.DESCRIPTION

Gets gateway by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A gateway id

.EXAMPLE

Get-IqsGateway -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/gateways/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsGateway
{
<#
.SYNOPSIS

Creates a new gateway

.DESCRIPTION

Creates a new gateway

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Gateway

A gateway with the following structure:
- id: string
- org_id: string
- model: string
- version: number
- udi: string
- label: string
- create_time: Date
- active: boolean

.EXAMPLE

New-IqsGateway -OrgId 1 -Gateway @{ org_id="1"; model="MCTD"; udi="134552345"; label="Main building"; active=$true }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Gateway
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/gateways" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Gateway
        
        Write-Output $result
    }
    end {}
}


function Update-IqsGateway
{
<#
.SYNOPSIS

Updates an existing gateway

.DESCRIPTION

Updates an existing gateway

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Gateway

A gateway with the following structure:
- id: string
- org_id: string
- model: string
- version: number
- udi: string
- label: string
- create_time: Date
- active: boolean

.EXAMPLE

Update-IqsGateway -OrgId 1 -Gateway @{ org_id="1"; model="MCTD"; udi="3454363645"; label="Main building"; active=$true }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Gateway
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/gateways/{1}" -f $OrgId, $Gateway.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Gateway
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsGateway
{
<#
.SYNOPSIS

Removes gateway by id

.DESCRIPTION

Removes gateway by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A gateway id

.EXAMPLE

Remove-IqsGateway -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/gateways/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Ping-IqsGateway
{
<#
.SYNOPSIS

Pings an existing gateway

.DESCRIPTION

Pings an existing gateway

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A gateway id

.EXAMPLE

Ping-IqsGateway -OrgId 1 -Id "123"

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
        $route = "/api/v1/organizations/{0}/gateways/{1}/ping" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Request-IqsGatewayStats
{
<#
.SYNOPSIS

Requests comm statistics from an existing gateway

.DESCRIPTION

Requests comm statistics from an existing gateway

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A gateway id

.EXAMPLE

Request-IqsGatewayStats -OrgId 1 -Id "123"

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
        $route = "/api/v1/organizations/{0}/gateways/{1}/request_stats" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route
        
        Write-Output $result
    }
    end {}
}
