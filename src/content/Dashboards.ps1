########################################################
##
## Dashboards.ps1
## Management interface to IQuipsys Positron
## Dashboards commands
##
#######################################################


function Get-IqsDashboards
{
<#
.SYNOPSIS

Gets page with dashboards by specified criteria

.DESCRIPTION

Gets a page with dashboards that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/v1/dashboards)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsDashboards -Filter @{ user_id="123"; app="testapp" } -Take 10

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
        Get-PipDashboards -Connection $Connection -Method "Get" -Uri "/api/v1/dashboards" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsDashboard
{
<#
.SYNOPSIS

Gets user dashboard for specified application and kind

.DESCRIPTION

Gets user dashboard for specified application and kind

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/v1/dashboards/{0}/{1}/{2})

.PARAMETER UserId

A unique user id

.PARAMETER App

Application name

.PARAMETER Kind

A dashboard kind. It allows to have more then one dashboard per application (default value: 'default')

.EXAMPLE

Get-IqsDashboard -UserId 123 -App testapp

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $UserId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string] $App,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Kind = "default"
    )
    begin {}
    process 
    {
        Get-PipDashboard -Connection $Connection -Method "Get" -Uri "/api/v1/dashboards/{0}/{1}/{2}" -UserId $UserId -App $App -Kind $Kind
    }
    end {}
}


function Set-IqsDashboard
{
<#
.SYNOPSIS

Sets a new or an existing dashboard

.DESCRIPTION

Sets a new or an existing dashboard

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Post')

.PARAMETER Uri

An operation uri (default: /api/v1/dashboards/{0}/{1}/{2})

.PARAMETER Dashboard

A dashboard with the following structure:
- id: string
- user_id: string
- app: string
- kind: string
- groups: TileGroupV1[]
  - title: string
  - index: number
  - tiles: TileV1[]
    - title: string
    - index: number
    - color: string
    - size: string
    - params: any

.EXAMPLE

Set-IqsDashboard -Dashboard @{ user_id="123"; app="MyApp"; kind="Default"; groups=@() }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Dashboard
    )
    begin {}
    process 
    {
        Set-PipDashboard -Connection $Connection -Method "Post" -Uri "/api/v1/dashboards/{0}/{1}/{2}" -Dashboard $Dashboard
    }
    end {}
}


function Remove-IqsDashboards
{
<#
.SYNOPSIS

Removes dashboards by specified filter criteria

.DESCRIPTION

Removes dashboards by specified filter criteria

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/v1/dashboards)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Remove-IqsDashboards -Filter @{ user_id="123" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{}
    )
    begin {}
    process 
    {
        Remove-PipDashboards -Connection $Connection -Method "Delete" -Uri "/api/v1/dashboards" -Filter $Filter
    }
    end {}
}