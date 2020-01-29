########################################################
##
## Announcements.ps1
## Management interface to IQuipsys Positron
## System announcements commands
##
#######################################################


function Get-IqsAnnouncements
{
<#
.SYNOPSIS

Gets page with announcements by specified criteria

.DESCRIPTION

Gets a page with announcements that satisfy specified criteria

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

Get-IqsAnnouncements -Filter @{ tags="goals,success" } -Take 10

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
        Get-PipAnnouncements -Connection $Connection -Method "Get" -Uri "/api/v1/announcements" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsAnnouncement
{
<#
.SYNOPSIS

Gets announcement by id

.DESCRIPTION

Gets announcement by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A announcement id

.EXAMPLE

Get-IqsAnnouncement -Id 123

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
        Get-PipAnnouncement -Connection $Connection -Method "Get" -Uri "/api/v1/announcements/{0}" -Id $Id
    }
    end {}
}


function Get-IqsRandomAnnouncement
{
<#
.SYNOPSIS

Gets a random announcement

.DESCRIPTION

Gets a random announcement

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Get')

.PARAMETER Uri

An operation uri (default: /api/v1/announcements/random)

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Get-IqsRandomAnnouncement

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
        Get-PipRandomAnnouncement -Connection $Connection -Method "Get" -Uri "/api/v1/announcements/random" -Filter $Filter
    }
    end {}
}


function New-IqsAnnouncement
{
<#
.SYNOPSIS

Creates a new announcement

.DESCRIPTION

Creates a new announcement

.PARAMETER Connection

A connection object

.PARAMETER Announcement

A announcement with the following structure:
- id: string
- category: string
- app: string
- title: MultiString
- content: MultiString
- location: LocationV1
  - name: string
  - pos: any (GeoJSON)
- start_time: Date
- end_time: Date
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- importance: number
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-IqsAnnouncement -Announcement @{ category="testing"; creator=@{id="123"}; text=@{ en="Hurry slowly" }; content=@{ en="test content" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Announcement
    )
    begin {}
    process 
    {
        New-PipAnnouncement -Connection $Connection -Method "Post" -Uri "/api/v1/announcements" -Announcement $Announcement
    }
    end {}
}


function Update-IqsAnnouncement
{
<#
.SYNOPSIS

Creates a new announcement

.DESCRIPTION

Creates a new announcement

.PARAMETER Connection

A connection object

.PARAMETER Announcement

A announcement with the following structure:
- id: string
- category: string
- app: string
- title: MultiString
- content: MultiString
- location: LocationV1
  - name: string
  - pos: any (GeoJSON)
- start_time: Date
- end_time: Date
- pics: AttachmentV1[]
  - id: string
  - uri: string
- docs: AttachmentV1[]
  - id: string
  - uri: string
  - name: string
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- importance: number
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-IqsAnnouncement -Announcement @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Announcement
    )
    begin {}
    process 
    {
        Update-PipAnnouncement -Connection $Connection -Method "Put" -Uri "/api/v1/announcements/{0}" -Announcement $Announcement
    }
    end {}
}


function Remove-IqsAnnouncement
{
<#
.SYNOPSIS

Removes announcement by id

.DESCRIPTION

Removes announcement by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Method

An operation method (default: 'Delete')

.PARAMETER Uri

An operation uri (default: /api/v1/announcements/{0})

.PARAMETER Id

A announcement id

.EXAMPLE

Remove-IqsAnnouncement -Id 123

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
        Remove-PipAnnouncement -Connection $Connection -Method "Delete" -Uri "/api/v1/announcements/{0}" -Id $Id
    }
    end {}
}