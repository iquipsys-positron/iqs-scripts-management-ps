########################################################
##
## EventTemplates.ps1
## Management interface to IQuipsys Positron
## EventTemplates commands
##
#######################################################


function Get-IqsEventTemplates
{
<#
.SYNOPSIS

Gets page with templates by specified criteria

.DESCRIPTION

Gets a page with templates that satisfy specified criteria

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

Get-IqsEventTemplates -OrgId 1 -Filter @{ name="truck" } -Take 10

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
        $route = "/api/v1/organizations/{0}/event_templates" -f $OrgId

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


function Get-IqsEventTemplate
{
<#
.SYNOPSIS

Gets template by id

.DESCRIPTION

Gets template by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A template id

.EXAMPLE

Get-IqsEventTemplate -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/event_templates/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsEventTemplate
{
<#
.SYNOPSIS

Creates a new template

.DESCRIPTION

Creates a new template

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Template

A template with the following structure:
- id: string
- org_id: string
- severity: number
- description: string
- set_time: boolean
- set_object: boolean
- set_pos: boolean

.EXAMPLE

# Creates a new template
New-IqsEventTemplate -OrgId 1 -Template @{ org_id="1"; severity=500; description="Test event" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Template
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/event_templates" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Template
        
        Write-Output $result
    }
    end {}
}


function Update-IqsEventTemplate
{
<#
.SYNOPSIS

Creates a new template

.DESCRIPTION

Creates a new template

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Template

A template with the following structure:
- id: string
- org_id: string
- severity: number
- description: string
- set_time: boolean
- set_object: boolean
- set_pos: boolean

.EXAMPLE

# Update existing template
Update-IqsEventTemplate -OrgId 1 -Template @{ org_id="1"; severity=500; description="Test event" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Template
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/event_templates/{1}" -f $OrgId, $Template.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Template
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsEventTemplate
{
<#
.SYNOPSIS

Removes template by id

.DESCRIPTION

Removes template by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A template id

.EXAMPLE

Remove-IqsEventTemplate -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/event_templates/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}