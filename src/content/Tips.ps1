########################################################
##
## Tips.ps1
## Management interface to IQuipsys Positron
## Tips commands
##
#######################################################


function Get-IqsTips
{
<#
.SYNOPSIS

Gets page with tips by specified criteria

.DESCRIPTION

Gets a page with tips that satisfy specified criteria

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

Get-IqsTips -Filter @{ tags="goals,success" } -Take 10

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
        Get-PipTips -Connection $Connection -Method "Get" -Uri "/api/v1/tips" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsTip
{
<#
.SYNOPSIS

Gets tip by id

.DESCRIPTION

Gets tip by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A tip id

.EXAMPLE

Get-IqsTip -Id 123

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
        Get-PipTip -Connection $Connection -Method "Get" -Uri "/api/v1/tips/{0}" -Id $Id
    }
    end {}
}


function Get-IqsRandomTip
{
<#
.SYNOPSIS

Gets a random tip

.DESCRIPTION

Gets a random tip

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/v1/tips/random)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Get-IqsRandomTip

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
       Get-RandomTip -Connection $Connection -Method "Get" -Uri "/api/v1/tips/random" -Filter $Filter
    }
    end {}
}


function New-IqsTip
{
<#
.SYNOPSIS

Creates a new tip

.DESCRIPTION

Creates a new tip

.PARAMETER Connection

A connection object

.PARAMETER Tip

A tip with the following structure:
- id: string
- topics: string[]
- title: MultiString
- content: MultiString
- more_url: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-IqsTip -Tip @{ topics=@("myapp", "useful"); title=@{ en="Do you know how to?" }; content=@{ en="Just press the button..." }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Tip
    )
    begin {}
    process 
    {
        New-PipTip -Connection $Connection -Method "Post" -Uri "/api/v1/tips" -Tip $Tip
    }
    end {}
}


function Update-IqsTip
{
<#
.SYNOPSIS

Creates a new tip

.DESCRIPTION

Creates a new tip

.PARAMETER Connection

A connection object

.PARAMETER Tip

A tip with the following structure:
- id: string
- topics: string[]
- title: MultiString
- content: MultiString
- more_url: string
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-IqsTip -Tip @{ id="123"; topics=@("myapp", "useful"); title=@{ en="Do you know how to?" }; content=@{ en="Just press the button..." }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Tip
    )
    begin {}
    process 
    {
        Update-PipTip -Connection $Connection -Method "Put" -Uri "/api/v1/tips/{0}" -Tip $Tip
    }
    end {}
}


function Remove-IqsTip
{
<#
.SYNOPSIS

Removes tip by id

.DESCRIPTION

Removes tip by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/v1/tips/{0})

.PARAMETER Id

A tip id

.EXAMPLE

Remove-IqsTip -Id 123

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
        Remove-PipTip -Connection $Connection -Method "Delete" -Uri "/api/v1/tips/{0}" -Id $Id
    }
    end {}
}