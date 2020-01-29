########################################################
##
## Applications.ps1
## Management interface to IQuipsys Positron
## Applications commands
##
#######################################################


function Get-IqsApplications
{
<#
.SYNOPSIS

Gets page with applications by specified criteria

.DESCRIPTION

Gets a page with applications that satisfy specified criteria

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

Get-IqsApplications -Filter @{ tags="goals,success" } -Take 10

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
        Get-PipApplications -Connection $Connection -Method "Get" -Uri "/api/v1/applications" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsApplication
{
<#
.SYNOPSIS

Gets application by id

.DESCRIPTION

Gets application by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A application id

.EXAMPLE

Get-IqsApplication -Id 123

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
        Get-PipApplication -Connection $Connection -Method "Get" -Uri "/api/v1/applications/{0}" -Id $Id
    }
    end {}
}


function New-IqsApplication
{
<#
.SYNOPSIS

Creates a new application

.DESCRIPTION

Creates a new application

.PARAMETER Connection

A connection object

.PARAMETER Application

A application with the following structure:
- id: string
- name: string
- description: string
- product: string
- copyrights: string
- min_ver: number
- max_ver: number

.EXAMPLE

New-IqsApplication -Application @{ id="my_app"; name="My Application"; product="My Samples" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Application
    )
    begin {}
    process 
    {
        New-PipApplication -Connection $Connection -Method "Post" -Uri "/api/v1/applications" -Application $Application
    }
    end {}
}


function Update-IqsApplication
{
<#
.SYNOPSIS

Updates a application

.DESCRIPTION

Updates a application by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Application

A application with the following structure:
- id: string
- name: string
- description: string
- product: string
- copyrights: string
- min_ver: number
- max_ver: number

.EXAMPLE

Update-IqsApplication -Application @{ id="my_app"; name="My Application"; product="My Samples" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Application
    )
    begin {}
    process 
    {
        Update-PipApplication -Connection $Connection -Method "Put" -Uri "/api/v1/applications/{0}" -Application $Application
    }
    end {}
}


function Remove-IqsApplication
{
<#
.SYNOPSIS

Removes application by id

.DESCRIPTION

Removes application by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A application id

.EXAMPLE

Remove-IqsApplication -Id 123

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
        Remove-PipApplication -Connection $Connection -Method "Delete" -Uri "/api/v1/applications/{0}" -Id $Id
    }
    end {}
}