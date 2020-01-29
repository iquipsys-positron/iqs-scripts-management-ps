########################################################
##
## CreditCards.ps1
## Management interface to IQuipsys Positron
## Credit cards commands
##
#######################################################


function Get-IqsCreditCards
{
<#
.SYNOPSIS

Gets page with credit cards by specified criteria

.DESCRIPTION

Gets a page with credit cards that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER CustomerId

A customer id

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER Total

A include total count (default: false)

.EXAMPLE

Get-IqsCreditCards -CustomerId 1 -Filter @{ customer_id="1" } -Take 10

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $CustomerId,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Filter = @{},
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [int] $Skip = 0,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [int] $Take = 100,
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [bool] $Total
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/credit_cards" -f $CustomerId

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


function Get-IqsCreditCard
{
<#
.SYNOPSIS

Gets credit card by id

.DESCRIPTION

Gets credit card by its unique id

.PARAMETER Connection

A connection object

.PARAMETER CustomerId

A customer id

.PARAMETER Id

A credit card id

.EXAMPLE

Get-IqsCreditCard -CustomerId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $CustomerId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/credit_cards/{1}" -f $CustomerId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route
        
        Write-Output $result
    }
    end {}
}


function New-IqsCreditCard
{
<#
.SYNOPSIS

Creates a new credit card

.DESCRIPTION

Creates a new credit card

.PARAMETER Connection

A connection object

.PARAMETER CustomerId

A customer id

.PARAMETER Card

A credit card with the following structure:
    id: string
    customer_id: string
    name?: string
    saved?: boolean
    default?: boolean
    create_time?: Date
    update_time?: Date
    type?: string - visa, mastercard, amex, discover, maestro
    number?: string
    expire_month?: number
    expire_year?: number
    first_name?: string
    last_name?: string
    billing_address?: AddressV1
        line1: string
        line2?: string
        city: string
        zip?: string
        postal_code?: string
        country_code: string - ISO 3166-1
    state?: string - ok, expired
    cvc?: string

.EXAMPLE

New-IqsCreditCard -CustomerId 2 -Card @{ customer_id="2"; first_name="Test"; last_name="Testing"; billing_address=@{line1="somewhere"; city="detroit"; country_code="123"}; state="ok"; type="visa"; number="1234567893481283"; expire_month=1; expire_year=2020 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $CustomerId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Card
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/credit_cards" -f $CustomerId

        $result = Invoke-PipFacade -Connection $Connection -Method "Post" -Route $route -Request $Card
        
        Write-Output $result
    }
    end {}
}


function Update-IqsCreditCard
{
<#
.SYNOPSIS

Creates a new credit card

.DESCRIPTION

Creates a new credit card

.PARAMETER Connection

A connection object

.PARAMETER CustomerId

A customer id

.PARAMETER Card

A credit card with the following structure:
    id: string
    customer_id: string
    name?: string
    saved?: boolean
    default?: boolean
    create_time?: Date
    update_time?: Date
    type?: string - visa, mastercard, amex, discover, maestro
    number?: string
    expire_month?: number
    expire_year?: number
    first_name?: string
    last_name?: string
    billing_address?: AddressV1
        line1: string
        line2?: string
        city: string
        zip?: string
        postal_code?: string
        country_code: string - ISO 3166-1
    state?: string - ok, expired
    cvc?: string

.EXAMPLE

Update-IqsCreditCard -CustomerId 1 -Card @{ customer_id="1"; state="ok"; type="visa"; number="1234567893481283"; expire_month=1; expire_year=2020 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $CustomerId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Card
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/credit_cards/{1}" -f $CustomerId, $Card.id

        $result = Invoke-PipFacade -Connection $Connection -Method "Put" -Route $route -Request $tCard
        
        Write-Output $result
    }
    end {}
}


function Remove-IqsCreditCard
{
<#
.SYNOPSIS

Removes credit card by id

.DESCRIPTION

Removes credit card by its unique id

.PARAMETER Connection

A connection object

.PARAMETER CustomerId

A customer id

.PARAMETER Id

A credit card id

.EXAMPLE

Remove-IqsCreditCard -CustomerId 1 -Id 123

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $CustomerId,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        $route = "/api/v1/organizations/{0}/credit_cards/{1}" -f $CustomerId, $Id

        $result = Invoke-PipFacade -Connection $Connection -Method "Delete" -Route $route
        
        Write-Output $result
    }
    end {}
}