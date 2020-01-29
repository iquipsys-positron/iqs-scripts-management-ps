########################################################
##
## Settings.ps1
## Management interface to IQuipsys Positron
## Settings commands
##
#######################################################

function Get-IqsSettingsSections
{
<#
.SYNOPSIS

Get section ids from settings

.DESCRIPTION

Gets a page of section ids from settings that satisfy specified criteria

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

Get-IqsSettingsSections

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
        [int] $Take = 100
    )
    begin {}
    process 
    {
        Get-PipSettingsSections -Connection $Connection -Method "Get" -Uri "/api/v1/settings/ids" -Filter $Filter -Skip $Skip -Take $Take
    }
    end {}
}


function Read-IqsSettingsSection
{
<#
.SYNOPSIS

Reads section from settings specified by its id

.DESCRIPTION

Gets requested section

.PARAMETER Connection

A connection object

.PARAMETER Section

A section id

.EXAMPLE

Read-IqsSettingsSection -Section 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Section
    )
    begin {}
    process 
    {
        Read-PipSettingsSection -Connection $Connection -Method "Get" -Uri "/api/v1/settings/{0}" -Section $Section
    }
    end {}
}


function Write-IqsSettingsSection
{
<#
.SYNOPSIS

Writes settings section specified by its is

.DESCRIPTION

Writes a hashtable into specified settings section

.PARAMETER Connection

A connection object

.PARAMETER Section

A section id

.PARAMETER Parameters

A section parameters

.EXAMPLE

Write-IqsSettingsSection -Section 123 -Parameters @{ key1=123; key2="ABC" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Section,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Parameters
    )
    begin {}
    process 
    {
        Write-PipSettingsSection -Connection $Connection -Method "Post" -Uri "/api/v1/settings/{0}" -Section $Section -Parameters $Parameters
    }
    end {}
}


function Read-IqsSettingsParam
{
<#
.SYNOPSIS

Reads parameter from settings section

.DESCRIPTION

Reads a single parameter from specified settings section

.PARAMETER Connection

A connection object

.PARAMETER Section

A section id

.PARAMETER Key

A parameter key

.EXAMPLE

Read-IqsSettingsParam -Section 123 -Key "language"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Section,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Key
    )
    begin {}
    process 
    {
        Read-PipSettingsParam -Connection $Connection -Method "Get" -Uri "/api/v1/settings/{0}/{1}" -Section $Section -Key $Key
    }
    end {}
}


function Write-IqsSettingsParam
{
<#
.SYNOPSIS

Writes settings parameter 

.DESCRIPTION

Writes a single parameter into specified settings section

.PARAMETER Connection

A connection object

.PARAMETER Section

A section id

.PARAMETER Key

A parameter key

.PARAMETER Value

A parameter value

.EXAMPLE

Write-IqsSettingsParam -Section 123 -Key language -Value en

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Section,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Key,
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [object] $Value
    )
    begin {}
    process 
    {
        Write-PipSettingsParam -Connection $Connection -Method "Post" -Uri "/api/v1/settings/{0}/{1}" -Section $Section -Key $Key -Value $Value
    }
    end {}
}


function Add-IqsSettingsParam
{
<#
.SYNOPSIS

Increment settings parameter 

.DESCRIPTION

Increments a single parameter by specified count

.PARAMETER Connection

A connection object

.PARAMETER Section

A section id

.PARAMETER Key

A parameter key

.PARAMETER Value

An increment count

.EXAMPLE

Add-IqsSettingsParam -Section 123 -Key attempt -Count 1

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Section,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Key,
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [object] $Value
    )
    begin {}
    process 
    {
        Add-PipSettingsParam -Connection $Connection -Method "Post" -Uri "/api/v1/settings/{0}/{1}/increment" -Section $Section -Key $Key -Value $Value
    }
    end {}
}