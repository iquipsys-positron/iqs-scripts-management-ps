########################################################
##
## Rules.ps1
## Management interface to IQuipsys Positron
## Rules commands
##
#######################################################


function Get-IqsEventRules
{
<#
.SYNOPSIS

Gets page with rules by specified criteria

.DESCRIPTION

Gets a page with rules that satisfy specified criteria

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

Get-IqsEventRules -OrgId 1 -Filter @{ type="object" } -Take 10

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
        $route = "/api/v1/organizations/{0}/event_rules" -f $OrgId

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


function Get-IqsEventRule
{
<#
.SYNOPSIS

Gets rule by id

.DESCRIPTION

Gets rule by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A rule id

.EXAMPLE

Get-IqsEventRule -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/event_rules/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsEventRule
{
<#
.SYNOPSIS

Creates a new rule

.DESCRIPTION

Creates a new rule

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Rule

A rule with the following structure:
- id: string
- org_id: string
- name: string
- type: string
- condition: any
- severity: number
- interval: number
- incident: boolean
- send_email: boolean
- emails: string[]
- send_signal: boolean
- signals: number
- include_object_ids: string[]
- exclude_object_ids: string[]
- include_group_ids: string[]
- exclude_group_ids: string[]
- include_zone_ids: string[]
- exclude_zone_ids: string[]

.EXAMPLE

New-IqsEventRule -OrgId 1 -Rule @{ org_id="1"; type="Presence"; name="Present in area"; event_type="auto" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Rule
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/event_rules" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Rule
        
        Write-Output $result
    }
    end {}
}


function Update-IqsEventRule
{
<#
.SYNOPSIS

Updates an event rule

.DESCRIPTION

Updates an event rule

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Rule

A rule with the following structure:
- id: string
- org_id: string
- name: string
- type: string
- condition: any
- severity: number
- interval: number
- incident: boolean
- send_email: boolean
- emails: string[]
- send_signal: boolean
- signals: number
- include_object_ids: string[]
- exclude_object_ids: string[]
- include_group_ids: string[]
- exclude_group_ids: string[]
- include_zone_ids: string[]
- exclude_zone_ids: string[]

.EXAMPLE

Update-IqsEventRule -OrgId 1 -Rule @{ org_id="1"; type="Presence"; name="Present in area"; event_type="auto" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Rule
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/event_rules/{1}" -f $OrgId, $Rule.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Rule
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsEventRule
{
<#
.SYNOPSIS

Removes rule by id

.DESCRIPTION

Removes rule by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A rule id

.EXAMPLE

Remove-IqsEventRule -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/event_rules/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}
