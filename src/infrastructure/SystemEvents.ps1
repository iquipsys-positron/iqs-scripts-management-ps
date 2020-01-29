########################################################
##
## EventLog.ps1
## Management interface to IQuipsys Positron
## Event log commands
##
#######################################################

function Read-IqsSystemEvents 
{
<#
.SYNOPSIS

Reads system events from event log

.DESCRIPTION

Gets a page of system evens from event log that satisfy specified criteria

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

Read-IqsSystemEvents -Filter @{ type="Failure" }

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
        Read-PipEvents -Connection $Connection -Method "Get" -Uri "/api/v1/eventlog" -Filter $Filter -Skip $Skip -Take $Take
    }
    end {}
}


function Write-IqsSystemEvent
{
<#
.SYNOPSIS

Writes event into event log

.DESCRIPTION

Writes a single event into event log

.PARAMETER Connection

A connection object

.PARAMETER Event

An event to be written:
- id: string
- time: Date
- correlation_id: string
- source: string
- type: string
- severity: EventLogSeverityV1
- message: string
- details: Hashtable

.EXAMPLE

Write-IqsSystemEvent -Event @{ correlation_id="123"; type="Other"; message="Just a test event" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Event
    )
    begin {}
    process 
    {
        Write-PipEvent -Connection $Connection -Method "Post" -Uri "/api/v1/eventlog" -Event $Event
    }
    end {}
}
