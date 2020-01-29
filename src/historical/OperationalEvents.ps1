########################################################
##
## OperationalEvents.ps1
## Management interface to IQuipsys Positron
## OperationalEvents commands
##
#######################################################


function Get-IqsOperationalEvents
{
<#
.SYNOPSIS

Gets page with events by specified criteria

.DESCRIPTION

Gets a page with events that satisfy specified criteria

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

Get-IqsOperationalEvents -OrgId 1 -Filter @{ name="truck" } -Take 10

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
        $route = "/api/v1/organizations/{0}/operational_events" -f $OrgId

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


function New-IqsOperationalEvent
{
<#
.SYNOPSIS

Creates a new event

.DESCRIPTION

Creates a new event

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Event

A event with the following structure:
- id: string
- org_id: string
- create_time: Date
- creator_id: string
- type: string
- rule_id: string
- severity: number
- time: Date
- pos: any
- group_id: string
- object_id: string
- loc_id: string
- zone_id: string
- ref_event_id: string
- description: string
- expected_value: any
- actual_value: any
- value_units: string

.EXAMPLE

New-IqsOperationalEvent -OrgId 1 -Event @{ org_id="1"; type="manual"; severity=500; description="Test event" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Event
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/operational_events" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Event
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsOperationalEvent
{
<#
.SYNOPSIS

Removes event by id

.DESCRIPTION

Removes event by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A event id

.EXAMPLE

Remove-IqsOperationalEvent -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/operational_events/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}