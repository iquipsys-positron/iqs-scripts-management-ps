########################################################
##
## Resolutions.ps1
## Management interface to IQuipsys Positron
## Resolutions commands
##
#######################################################


function Get-IqsResolutions
{
<#
.SYNOPSIS

Gets page with resolutions by specified criteria

.DESCRIPTION

Gets a page with resolutions that satisfy specified criteria

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

Get-IqsResolutions -OrgId 1 -Filter @{ search="gate" } -Take 10

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
        $route = "/api/v1/organizations/{0}/resolutions" -f $OrgId

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


function Get-IqsResolution
{
<#
.SYNOPSIS

Gets resolution by id

.DESCRIPTION

Gets resolution by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A resolution id

.EXAMPLE

Get-IqsResolution -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/resolutions/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsResolution
{
<#
.SYNOPSIS

Creates a new resolution

.DESCRIPTION

Creates a new resolution

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Resolution

A resolution with the following structure:
- id: string
- org_id: string
- rule_id: string
- resolution: string

.EXAMPLE

New-IqsResolution -OrgId 1 -Resolution @{ org_id="1"; rule_id="1"; resolution="Escalated to management" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Resolution
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/resolutions" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Resolution
        
        Write-Output $result
    }
    end {}
}


function Update-IqsResolution
{
<#
.SYNOPSIS

Updates a resolution

.DESCRIPTION

Updates a resolution

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Resolution

A resolution with the following structure:
- id: string
- org_id: string
- rule_id: string
- resolution: string

.EXAMPLE

Update-IqsResolution -OrgId 1 -Resolution @{ org_id="1"; rule_id="1"; resolution="Escalated to management" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Resolution
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/resolutions/{1}" -f $OrgId, $Resolution.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Resolution
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsResolution
{
<#
.SYNOPSIS

Removes resolution by id

.DESCRIPTION

Removes resolution by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A resolution id

.EXAMPLE

Remove-IqsResolution -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/resolutions/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}