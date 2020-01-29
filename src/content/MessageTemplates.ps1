########################################################
##
## MessageTemplates.ps1
## Management interface to IQuipsys Positron
## Message templates commands
##
#######################################################


function Get-IqsMessageTemplates
{
<#
.SYNOPSIS

Gets page with message templates by specified criteria

.DESCRIPTION

Gets a page with message templates that satisfy specified criteria

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

Get-IqsMessageTemplates -Filter @{ name="Welcome Message" } -Take 10

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
        Get-PipMessageTemplates -Connection $Connection -Method "Get" -Uri "/api/v1/msg_templates" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsMessageTemplate
{
<#
.SYNOPSIS

Gets message template by id

.DESCRIPTION

Gets message template by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A message template id

.EXAMPLE

Get-IqsMessageTemplate -Id 123

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
        Get-PipMessageTemplate -Connection $Connection -Method "Get" -Uri "/api/v1/msg_templates/{0}" -Id $Id
    }
    end {}
}


function New-IqsMessageTemplate
{
<#
.SYNOPSIS

Creates a new message template

.DESCRIPTION

Creates a new message template

.PARAMETER Connection

A connection object

.PARAMETER MessageTemplate

A message template with the following structure:
- id: string
- name: string
- from: string
- reply_to: string
- subject: MultiString
- text: MultiString
- html: MultiString
- status: string - new, writing, translating, verifying, completed

.EXAMPLE

New-IqsMessageTemplate -MessageTemplate @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $MessageTemplate
    )
    begin {}
    process 
    {
        New-PipMessageTemplate -Connection $Connection -Method "Post" -Uri "/api/v1/msg_templates" -MessageTemplate $MessageTemplate
    }
    end {}
}


function Update-IqsMessageTemplate
{
<#
.SYNOPSIS

Creates a new message template

.DESCRIPTION

Creates a new message template

.PARAMETER Connection

A connection object

.PARAMETER MessageTemplate

A message template with the following structure:
- id: string
- name: string
- from: string
- reply_to: string
- subject: MultiString
- text: MultiString
- html: MultiString
- status: string - new, writing, translating, verifying, completed

.EXAMPLE

Update-IqsMessageTemplate -MessageTemplate @{ text=@{ en="Hurry slowly" }; author=@{ en="Russian proverb" }; status="completed" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $MessageTemplate
    )
    begin {}
    process 
    {
        Update-PipMessageTemplate -Connection $Connection -Method "Put" -Uri "/api/v1/msg_templates/{0}" -MessageTemplate $MessageTemplate
    }
    end {}
}


function Remove-IqsMessageTemplate
{
<#
.SYNOPSIS

Removes message template by id

.DESCRIPTION

Removes message template by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A message template id

.EXAMPLE

Remove-IqsMessageTemplate -Id 123

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
        Remove-PipMessageTemplate -Connection $Connection -Method "Delete" -Uri "/api/v1/msg_templates/{0}" -Id $Id
    }
    end {}
}