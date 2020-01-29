########################################################
##
## ObjectGroups.ps1
## Management interface to IQuipsys Positron
## ObjectGroups commands
##
#######################################################


function Get-IqsObjectGroups
{
<#
.SYNOPSIS

Gets page with groups by specified criteria

.DESCRIPTION

Gets a page with groups that satisfy specified criteria

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

Get-IqsObjectGroups -OrgId 1 -Filter @{ name="truck" } -Take 10

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
        $route = "/api/v1/organizations/{0}/object_groups" -f $OrgId

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


function Get-IqsObjectGroup
{
<#
.SYNOPSIS

Gets group by id

.DESCRIPTION

Gets group by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A group id

.EXAMPLE

Get-IqsObjectGroup -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/object_groups/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsObjectGroup
{
<#
.SYNOPSIS

Creates a new group

.DESCRIPTION

Creates a new group

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Group

A group with the following structure:
- id: string
- org_id: string
- name: string
- object_ids: string[]

.EXAMPLE

New-IqsObjectGroup -OrgId 1 -Group @{ org_id="1"; name="Pickups"; object_ids=@("1", "2") }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Group
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_groups" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Group
        
        Write-Output $result
    }
    end {}
}


function Update-IqsObjectGroup
{
<#
.SYNOPSIS

Updates an object group

.DESCRIPTION

Updates an object group

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Group

A group with the following structure:
- id: string
- org_id: string
- name: string
- object_ids: string[]

.EXAMPLE

Update-IqsObjectGroup -OrgId 1 -Group @{ org_id="1"; name="Pickups"; object_ids=@("1", "2") }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Group
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_groups/{1}" -f $OrgId, $Group.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Group
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsObjectGroup
{
<#
.SYNOPSIS

Removes group by id

.DESCRIPTION

Removes group by its unique id

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Id

A group id

.EXAMPLE

Remove-IqsObjectGroup -OrgId 1 -Id 123

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
        $route = "/api/v1/organizations/{0}/object_groups/{1}" -f $OrgId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}