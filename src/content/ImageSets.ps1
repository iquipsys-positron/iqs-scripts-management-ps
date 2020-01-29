########################################################
##
## ImageSets.ps1
## Management interface to IQuipsys Positron
## ImageSets commands
##
#######################################################


function Get-IqsImageSets
{
<#
.SYNOPSIS

Gets page with imagesets by specified criteria

.DESCRIPTION

Gets a page with imagesets that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsImageSets -Filter @{ tags="goals,success" } -Take 10

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
        Get-PipImageSets -Connection $Connection -Method "Get" -Uri "/api/v1/imagesets" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsImageSet
{
<#
.SYNOPSIS

Gets imageset by id

.DESCRIPTION

Gets imageset by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A imageset id

.EXAMPLE

Get-IqsImageSet -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        Get-PipImageSet -Connection $Connection -Method "Get" -Uri "/api/v1/imagesets/{0}" -Id $Id
    }
    end {}
}


function New-IqsImageSet
{
<#
.SYNOPSIS

Creates a new imageset

.DESCRIPTION

Creates a new imageset

.PARAMETER Connection

A connection object

.PARAMETER ImageSet

A imageset with the following structure:
- id: string;
- title: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- tags: string[];

.EXAMPLE

New-IqsImageSet -ImageSet @{ title="Cats"; tags=@("cats"); pics=@(@{ id="123" }, @{ id="345" }) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $ImageSet
    )
    begin {}
    process 
    {
        New-PipImageSet -Connection $Connection -Method "Post" -Uri "/api/v1/imagesets" -ImageSet $ImageSet
    }
    end {}
}


function Update-IqsImageSet
{
<#
.SYNOPSIS

Creates a new imageset

.DESCRIPTION

Creates a new imageset

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Put')

.PARAMETER Uri

An operation uri (default: /api/v1/imagesets/{0})

.PARAMETER ImageSet

A imageset with the following structure:
- id: string;
- title: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- tags: string[];

.EXAMPLE

Update-IqsImageSet -ImageSet @{ title="Cats"; tags=@("cats"); pics=@(@{ id=123 }, @{ id=345 }) }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $ImageSet
    )
    begin {}
    process 
    {
        Update-PipImageSet -Connection $Connection -Method "Put" -Uri "/api/v1/imagesets/{0}" -ImageSet $ImageSet
    }
    end {}
}


function Remove-IqsImageSet
{
<#
.SYNOPSIS

Removes imageset by id

.DESCRIPTION

Removes imageset by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A imageset id

.EXAMPLE

Remove-IqsImageSet -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        Remove-PipImageSet -Connection $Connection -Method "Delete" -Uri "/api/v1/imagesets/{0}" -Id $Id
    }
    end {}
}