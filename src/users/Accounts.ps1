########################################################
##
## Accounts.ps1
## Management interface to IQuipsys Positron
## User accounts commands
##
#######################################################


function Get-IqsAccounts
{
<#
.SYNOPSIS

Gets user accounts by specified criteria

.DESCRIPTION

Gets a page with accounts that satisfy specified criteria

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

Get-IqsAccounts -Take 10

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
        Get-PipAccounts -Connection $Connection -Method "Get" -Uri "/api/v1/accounts" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsAccount
{
<#
.SYNOPSIS

Gets user account by id

.DESCRIPTION

Gets user account by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A user account id

.EXAMPLE

Get-IqsAccount -Id 123

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
        Get-PipAccount -Connection $Connection -Method "Get" -Uri "/api/v1/accounts/{0}" -Id $Id
    }
    end {}
}


function Get-IqsCurrentAccount
{
<#
.SYNOPSIS

Gets the current user account

.DESCRIPTION

Gets the current user account

.PARAMETER Connection

A connection object

.EXAMPLE

Get-IqsCurrentAccount

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection
    )
    begin {}
    process 
    {
        Get-PipAccount -Connection $Connection -Method "Get" -Uri "/api/v1/accounts/{0}" -Id current
    }
    end {}
}


function New-IqsAccount
{
<#
.SYNOPSIS

Creates a new user account

.DESCRIPTION

Creates a new user account, sets email address and temporary password.
Check the assigned password in the result object.

.PARAMETER Connection

A connection object

.PARAMETER Account

An account with the following structure
- email: string
- name: string
- login: string
- password: string
- about: string (optional)
- theme: string  (optional)
- language: string (optional)
- theme: string (optional)

.EXAMPLE

New-IqsAccount -Account @{ name="Test User"; login="test"; email="test@somewhere.com" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Account
    )
    begin {}
    process 
    {
        New-PipAccount -Connection $Connection -Method "Post" -Uri "/api/v1/accounts" -Account $Account
    }
    end {}
}


function Update-IqsAccount
{
<#
.SYNOPSIS

Updates a user account

.DESCRIPTION

Updates a user account

.PARAMETER Connection

A connection object

.PARAMETER Account

An account with the following structure
- email: string
- name: string
- login: string
- password: string
- about: string (optional)
- theme: string  (optional)
- language: string (optional)
- theme: string (optional)

.EXAMPLE

Update-IqsAccount -Account @{ name="Test User"; login="test"; email="test@somewhere.com"; }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Account
    )
    begin {}
    process 
    {
        Update-PipAccount -Connection $Connection -Method "Put" -Uri "/api/v1/accounts/{0}" -Account $Account
    }
    end {}
}


function Remove-IqsAccount
{
<#
.SYNOPSIS

Removes user account by id

.DESCRIPTION

Removes user account by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A user account id

.EXAMPLE

Remove-IqsAccount -Id 123

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
        Remove-PipAccount -Connection $Connection -Method "Delete" -Uri "/api/v1/accounts/{0}" -Id $Id
    }
    end {}
}