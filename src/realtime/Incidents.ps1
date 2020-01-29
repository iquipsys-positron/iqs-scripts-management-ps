########################################################
##
## Incidents.ps1
## Management interface to IQuipsys Positron
## Incidents commands
##
#######################################################


function Get-IqsIncidents
{
<#
.SYNOPSIS

Gets page with incidents by specified criteria

.DESCRIPTION

Gets a page with incidents that satisfy specified criteria

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

Get-IqsIncidents -OrgId 1 -Take 10

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
        $route = "/api/v1/organizations/{0}/incidents" -f $OrgId

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


function Get-IqsIncident
{
<#
.SYNOPSIS

Gets incident by id

.DESCRIPTION

Gets incident by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A incident id

.EXAMPLE

Get-IqsIncident -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/incidents/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsIncident
{
<#
.SYNOPSIS

Creates a new incident

.DESCRIPTION

Creates a new incident

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Incident

A incident with the following structure:
- id: string
- org_id: string
- event_id: string
- rule_id: string
- severity: number
- time: Date
- pos: any
- group_id: string
- object_id: string
- loc_id: string
- zone_id: string
- resolution: string
- resolution_id: string
- description: string
- expected_value: any
- actual_value: any
- value_units: string

.EXAMPLE

New-IqsIncident -OrgId 1 -Incident @{ org_id="1"; rule_id="123"; event_id="234"; description="Test incident"; severity=50 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Incident
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/incidents" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Incident
        
        Write-Output $result
    }
    end {}
}


function Close-IqsIncident
{
<#
.SYNOPSIS

Closes incident

.DESCRIPTION

Closes incident and records resolution

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A incident id

.PARAMETER ResolutionId

A unique incident resolution

.PARAMETER Resolution

A incident resolution

.EXAMPLE

Close-IqsIncident -OrgId 1 -Id 123 -Resolution "Test completed" -ResolutionId "1"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $ResolutionId,
        [Parameter(Mandatory=$true, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [string] $Resolution
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/incidents/{1}" -f $OrgId, $Id
        $request = @{ 
            resolution=$Resolution 
            resolution_id=$ResolutionId
        }

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $request
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsIncident
{
<#
.SYNOPSIS

Removes incident by id

.DESCRIPTION

Removes incident by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A incident id

.EXAMPLE

Remove-IqsIncident -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/incidents/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}