########################################################
##
## ControlObjects.ps1
## Management interface to IQuipsys Positron
## ControlObjects commands
##
#######################################################


function Get-IqsControlObjects
{
<#
.SYNOPSIS

Gets page with objects by specified criteria

.DESCRIPTION

Gets a page with objects that satisfy specified criteria

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

Get-IqsControlObjects -OrgId 1 -Filter @{ search="Peter" } -Take 10

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
        $route = "/api/v1/organizations/{0}/control_objects" -f $OrgId

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


function Get-IqsControlObject
{
<#
.SYNOPSIS

Gets object by id

.DESCRIPTION

Gets object by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A object id

.EXAMPLE

Get-IqsControlObject -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/control_objects/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsControlObject
{
<#
.SYNOPSIS

Creates a new object

.DESCRIPTION

Creates a new object

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Object

A object with the following structure:
- id: string
- org_id: string
- category: string
- type: string
- deleted: boolean
- name: string
- description: string
- phone: string
- pin: string
- device_id: string
- group_ids: string[]

.EXAMPLE

New-IqsControlObject -OrgId 1 -Object @{ org_id="1"; category="equipment"; type="haul"; name="T101"; group_ids=@("1", "2") }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Object
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/control_objects" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Object
        
        Write-Output $result
    }
    end {}
}


function Update-IqsControlObject
{
<#
.SYNOPSIS

Updates a control object

.DESCRIPTION

Updates a control object

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Object

A object with the following structure:
- id: string
- org_id: string
- category: string
- type: string
- deleted: boolean
- name: string
- description: string
- phone: string
- pin: string
- device_id: string
- group_ids: string[]

.EXAMPLE

Update-IqsControlObject -OrgId 1 -Object @{ org_id="1"; category="equipment"; type="haul"; name="T101"; group_ids=@("1", "2") }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Object
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/control_objects/{1}" -f $OrgId, $Object.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Object
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsControlObject
{
<#
.SYNOPSIS

Removes object by id

.DESCRIPTION

Removes object by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A object id

.EXAMPLE

Remove-IqsControlObject -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/control_objects/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}