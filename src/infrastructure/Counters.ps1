########################################################
##
## Counters.ps1
## Management interface to IQuipsys Positron
## Counters commands
##
#######################################################

function Read-IqsCounters
{
<#
.SYNOPSIS

Reads performance counters from counters service

.DESCRIPTION

Reads a page of performance counters from counters service that satisfy specified criteria

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

.PARAMETER AsText

Switch to read performance counters as text

.EXAMPLE

Read-IqsCounters -Filter @{ search="Invoice" } -Take 10 -AsText

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
        [bool] $Total,
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [switch] $AsText
    )
    begin {}
    process 
    {
        if ($AsText) {
            Read-PipCounters -Connection $Connection -Method "Get" -Uri "/api/v1/counters" -Filter $Filter -Skip $Skip -Take $Take -Total $Total -AsText
        } else {
            Read-PipCounters -Connection $Connection -Method "Get" -Uri "/api/v1/counters" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
        }
    }
    end {}
}


function Write-IqsCounter
{
<#
.SYNOPSIS

Writes a performance counter

.DESCRIPTION

Writes a performance counter into counters service

.PARAMETER Connection

A connection object

.PARAMETER Counter

A counter object with the following structure
- name: string
- type: CounterType (0: Interval, 1: LastValue, 2: Statistics, 3: Timestamp, 4: Increment)
- last: number
- count: number
- min: number
- max: number
- average: number
- time: Date

.EXAMPLE

Write-IqsCounter -Counter @{ name="test.total_calls"; type=4; count=1 }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Counter
    )
    begin {}
    process 
    {
        Write-PipCounter -Connection $Connection -Method "Post" -Uri "/api/v1/counters" -Counter $Counter
    }
    end {}
}


function Clear-IqsCounters
{
<#
.SYNOPSIS

Clears all performance counters on the server

.DESCRIPTION

Clears all performance counters on the server

.PARAMETER Connection

A connection object

.EXAMPLE

Clear-IqsCounters

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
        Clear-PipCounters -Connection $Connection -Method "Delete" -Uri "/api/v1/counters"
    }
    end {}
}