########################################################
##
## ObjectData.ps1
## Management interface to IQuipsys Positron
## ObjectData commands
##
#######################################################


function Get-IqsObjectData
{
<#
.SYNOPSIS

Gets page with data by specified criteria

.DESCRIPTION

Gets a page with data that satisfy specified criteria

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

Get-IqsObjectData -OrgId 1 -Filter @{ object_id="123" } -Take 10

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
        $route = "/api/v1/organizations/{0}/object_data" -f $OrgId

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


function Add-IqsObjectData
{
<#
.SYNOPSIS

Adds data to object data

.DESCRIPTION

Adds data to object data

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Data

A data with the following structure:
- org_id: string
- object_id: string
- time: Date
- params: ObjectValueV1
- events: ObjectValueV1
- commands: ObjectValueV1
- states: ObjectValueV1

.EXAMPLE

Add-IqsObjectData -OrgId 1 -Data @{ org_id="1"; object_id="123"; params=@( @{ id=1; typ=1; val=123 } ) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Data
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_data" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Data
        
        Write-Output $result
    }
    end {}
}


function Add-IqsObjectDataBatch
{
<#
.SYNOPSIS

Adds multiple object data

.DESCRIPTION

Adds several data to object data

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Data

A data with the following structure:
- org_id: string
- object_id: string
- time: Date
- params: ObjectValueV1
- events: ObjectValueV1
- commands: ObjectValueV1
- states: ObjectValueV1

.EXAMPLE

Add-IqsObjectDataBatch -OrgId 1 -Data @( @{ org_id="1"; object_id="123"; params=@( @{ id=1; typ=1; val=123 } ) }, ... )

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object[]] $Data
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_data/batch" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Data
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsObjectData
{
<#
.SYNOPSIS

Removes data by filter

.DESCRIPTION

Removes data that match specified filter

.PARAMETER Connection

A connection object

.PARAMETER OrgId

A organization id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

# Delete data for object 123
Remove-IqsObjectData -OrgId 1 -Filter @{ object_id="123" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $OrgId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{}
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/object_data" -f $OrgId

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route -Params $Filter
        
        Write-Output $result
    }
    end {}
}