########################################################
##
## HelpArticles.ps1
## Management interface to IQuipsys Positron
## Help articles commands
##
#######################################################


function Get-IqsHelpArticles
{
<#
.SYNOPSIS

Gets page with help articles by specified criteria

.DESCRIPTION

Gets a page with help articles that satisfy specified criteria

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

Get-IqsHelpArticles -Filter @{ tags="goals,success" } -Take 10

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
        Get-PipHelpArticles -Connection $Connection -Method "Get" -Uri "/api/v1/help/articles" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsHelpArticle
{
<#
.SYNOPSIS

Gets help article by id

.DESCRIPTION

Gets help article by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A article id

.EXAMPLE

Get-IqsHelpArticle -Id 123

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
        Get-PipHelpArticle -Connection $Connection -Method "Get" -Uri "/api/v1/help/articles/{0}" -Id $Id
    }
    end {}
}


function Get-IqsRandomHelpArticle
{
<#
.SYNOPSIS

Gets a random help article

.DESCRIPTION

Gets a random help article

.PARAMETER Connection

A connection object

.PARAMETER Filter

A filter with search criteria (default: no filter)

.EXAMPLE

Get-IqsRandomArticle

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
        Get-PipRandomHelpArticle -Connection $Connection -Method "Get" -Uri "/api/v1/help/articles/random" -Filter $Filter
        
        Write-Output $result
    }
    end {}
}


function New-IqsHelpArticle
{
<#
.SYNOPSIS

Creates a new help article

.DESCRIPTION

Creates a new help article

.PARAMETER Connection

A connection object

.PARAMETER Article

A article with the following structure:
- id: string
- topic_id: string
- app: string
- min_ver: number
- max_ver: number
- content: HelpArticleContentV1[]
  - language: string
  - title: string
  - content: ContentBlockV1[]
    - type: string - text, checklist, pictures, documents, location, time, custom
    - text: string
    - checklist: ChecklistItemV1[]
      - text: string
      - checked: boolean
    - loc_name: string
    - loc_pos: object - GeoJSON
    - start: Date
    - end: Date
    - all_day: boolean
    - pic_ids: string[]
    - docs: DocumentV1[]
      - file_id: string
      - file_name: string
    - custom: object
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-IqsHelpArticle -Article @{ topic_id="1"; app="MyApp"; min_ver=0; max_ver=9999; content=@(@{ language="en"; title="About MyApp" }); status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Article
    )
    begin {}
    process 
    {
        New-PipHelpArticle -Connection $Connection -Method "Post" -Uri "/api/v1/help/articles" -Article $Article
    }
    end {}
}


function Update-IqsHelpArticle
{
<#
.SYNOPSIS

Updates a help article

.DESCRIPTION

Updates a help article by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Article

A article with the following structure:
- id: string
- topic_id: string
- app: string
- min_ver: number
- max_ver: number
- content: HelpArticleContentV1[]
  - language: string
  - title: string
  - content: ContentBlockV1[]
    - type: string - text, checklist, pictures, documents, location, time, custom
    - text: string
    - checklist: ChecklistItemV1[]
      - text: string
      - checked: boolean
    - loc_name: string
    - loc_pos: object - GeoJSON
    - start: Date
    - end: Date
    - all_day: boolean
    - pic_ids: string[]
    - docs: DocumentV1[]
      - file_id: string
      - file_name: string
    - custom: object
- tags: string[]
- status: string - new, writing, translating, verifying, completed
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-IqsHelpArticle -Article @{ id="123"; topic_id="1"; app="MyApp"; min_ver=0; max_ver=9999; content=@(@{ language="en"; title="About MyApp" }); status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Article
    )
    begin {}
    process 
    {
        Update-PipHelpArticle -Connection $Connection -Method "Put" -Uri "/api/v1/help/articles/{0}" -Article $Article
    }
    end {}
}


function Remove-IqsHelpArticle
{
<#
.SYNOPSIS

Removes help article by id

.DESCRIPTION

Removes help article by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A article id

.EXAMPLE

Remove-IqsHelpArticle -Id 123

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
        Remove-PipHelpArticle -Connection $Connection -Method "Delete" -Uri "/api/v1/help/articles/{0}" -Id $Id
    }
    end {}
}