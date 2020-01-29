########################################################
##
## HelpTopics.ps1
## Management interface to IQuipsys Positron
## Help topics commands
##
#######################################################


function Get-IqsHelpTopics
{
<#
.SYNOPSIS

Gets page with help topics by specified criteria

.DESCRIPTION

Gets a page with help topics that satisfy specified criteria

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

Get-IqsHelpTopics -Filter @{ qapp="MyApp" } -Take 10

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
        Get-PipHelpTopics -Connection $Connection -Method "Get" -Uri "/api/v1/help/topics" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsHelpTopic
{
<#
.SYNOPSIS

Gets help topic by id

.DESCRIPTION

Gets help topic by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A topic id

.EXAMPLE

Get-IqsHelpTopic -Id 123

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
        Get-PipHelpTopic -Connection $Connection -Method "Get" -Uri "/api/v1/help/topics/{0}" -Id $Id
    }
    end {}
}


function New-IqsHelpTopic
{
<#
.SYNOPSIS

Creates a new help topic

.DESCRIPTION

Creates a new help topic

.PARAMETER Connection

A connection object

.PARAMETER Topic

A topic with the following structure:
- id: string
- parent_id: string
- app: string
- title: MultiString
- popular: boolean
- custom_hdr: any
- custom_dat: any

.EXAMPLE

New-IqsHelpTopic -Topic @{ parent_id="1"; app="MyApp"; title=@{ en="Application Help" } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Topic
    )
    begin {}
    process 
    {
        New-PipHelpTopic -Connection $Connection -Method "Post" -Uri "/api/v1/help/topics" -Topic $Topic
    }
    end {}
}


function Update-IqsHelpTopic
{
<#
.SYNOPSIS

Updates a help topic

.DESCRIPTION

Updates a help topic by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Topic

A topic with the following structure:
- id: string
- parent_id: string
- app: string
- title: MultiString
- popular: boolean
- custom_hdr: any
- custom_dat: any

.EXAMPLE

Update-IqsHelpTopic -Topic @{ id="123"; parent_id="1"; app="MyApp"; title=@{ en="Application Help" } }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Topic
    )
    begin {}
    process 
    {
        Update-PipHelpTopic -Connection $Connection -Method "Put" -Uri "/api/v1/help/topics/{0}" -Topic $Topic
    }
    end {}
}


function Remove-IqsHelpTopic
{
<#
.SYNOPSIS

Removes help topic by id

.DESCRIPTION

Removes help topic by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A topic id

.EXAMPLE

Remove-IqsHelpTopic -Id 123

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
        Remove-PipHelpTopic -Connection $Connection -Method "Delete" -Uri "/api/v1/help/topics/{0}" -Id $Id
    }
    end {}
}