########################################################
##
## Agreements.ps1
## Management interface to IQuipsys Positron
## Agreements commands
##
#######################################################


function Get-IqsAgreements
{
<#
.SYNOPSIS

Gets page with agreements by specified criteria

.DESCRIPTION

Gets a page with agreements that satisfy specified criteria

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

Get-IqsAgreements -Filter @{ active=$true } -Take 10

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
        $route = "/api/v1/agreements"

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


function Test-IqsAgreement
{
<#
.SYNOPSIS

Verifies agreement by its number

.DESCRIPTION

Checks if agreement with specified number exists

.PARAMETER Connection

A connection object

.PARAMETER Number

A agreement number

.EXAMPLE

Test-IqsAgreement -Number 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Number
    )
    begin {}
    process 
    {
        $route = "/api/v1/agreements/verify?number={0}" -f $Number

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}

function Get-IqsAgreement
{
<#
.SYNOPSIS

Gets agreement by id

.DESCRIPTION

Gets agreement by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A agreement id

.EXAMPLE

Get-IqsAgreement -Id 123

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
        $route = "/api/v1/agreements/{0}" -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsAgreement
{
<#
.SYNOPSIS

Creates a new agreement

.DESCRIPTION

Creates a new agreement

.PARAMETER Connection

A connection object

.PARAMETER Agreement

A agreement with the following structure:
- id: string
- number: string
- create_time?: Date
- active?: boolean
- start_time: Date
- end_time: Date
- company: string
- content?: string

.EXAMPLE

New-IqsAgreement -Agreement @{ id="1"; number="12345"; active=$true; start_time="2018-01-01T00:00:00"; end_time="2018-01-01T00:00:00"; company="XYZ Company" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Agreement
    )
    begin {}
    process 
    {
        $route = "/api/v1/agreements"

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Agreement
        
        Write-Output $result
    }
    end {}
}


function Update-IqsAgreement
{
<#
.SYNOPSIS

Creates a new agreement

.DESCRIPTION

Creates a new agreement

.PARAMETER Connection

A connection object

.PARAMETER Agreement

A agreement with the following structure:
- id: string
- number: string
- create_time?: Date
- active?: boolean
- start_time: Date
- end_time: Date
- company: string
- content?: string

.EXAMPLE

Update-IqsAgreement -Agreement @{ id="1"; number="12345"; active=$true; start_time="2018-01-01T00:00:00"; end_time="2018-01-01T00:00:00"; company="XYZ Company" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Agreement
    )
    begin {}
    process 
    {
        $route = "/api/v1/agreements/{0}" -f $Agreement.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $Agreement
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsAgreement
{
<#
.SYNOPSIS

Removes agreement by id

.DESCRIPTION

Removes agreement by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A agreement id

.EXAMPLE

Remove-IqsAgreement -Id 123

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
        $route = "/api/v1/agreements/{0}" -f $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}
