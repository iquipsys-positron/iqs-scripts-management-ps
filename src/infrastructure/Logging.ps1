########################################################
##
## Logging.ps1
## Management interface to IQuipsys Positron
## Logging commands
##
#######################################################

function Read-IqsLog
{
<#
.SYNOPSIS

Reads messages from logging service

.DESCRIPTION

Reads a page of messages from logging service that satisfy specified criteria

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

Switch to read log messages as text

.EXAMPLE

Read-IqsLog -Filter @{ search="Invoice" } -Take 10 -AsText

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
            Read-PipLog -Connection $Connection -Method "Get" -Uri "/api/v1/logging" -Filter $Filter -Skip $Skip -Take $Take -Total $Total -AsText
        } else {
            Read-PipLog -Connection $Connection -Method "Get" -Uri "/api/v1/logging" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
        }
    }
    end {}
}


function Read-IqsErrors 
{
<#
.SYNOPSIS

Reads error messages from logging service

.DESCRIPTION

Gets a page of error messages from logging service that satisfy specified criteria

.PARAMETER Connection

A connection object

.PARAMETER Filter

A filter with search criteria (default: no filter)

.PARAMETER Skip

A number of records to skip (default: 0)

.PARAMETER Take

A number of records to return (default: 100)

.PARAMETER AsText

Switch to read traces as text

.EXAMPLE

Read-IqsErrors -Filter @{ search="Invoice" } -Take 10 -AsText

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
            Read-PipErrors -Connection $Connection -Method "Get" -Uri "/api/v1/logging/errors" -Filter $Filter -Skip $Skip -Take $Take -Total $Total -AsText
        } else {
            Read-PipErrors -Connection $Connection -Method "Get" -Uri "/api/v1/logging/errors" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
        }
    }
    end {}
}


function Write-IqsLog
{
<#
.SYNOPSIS

Logs a message

.DESCRIPTION

Writes a message into logging service

.PARAMETER Connection

A connection object

.PARAMETER Message

A message with the following structure
- time: Date
- source: string
- level: LogLevel - (0: None, 1: Fatal, 2: Error, 3: Warn, 4: Info, 5: Debug, 6: Trace)
- correlation_id: string
- error: ErrorDescription
- message: string

.EXAMPLE

Write-IqsLog -Message @{ correlation_id="123"; level=2; source="Powershell" error=@{ message="Failed" }; message="Just a test" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Message
    )
    begin {}
    process 
    {
        Write-PipLog -Connection $Connection -Method "Post" -Uri "/api/v1/logging" -Message $Message
    }
    end {}
}

function Clear-IqsLog
{
<#
.SYNOPSIS

Clears all log messages on the server

.DESCRIPTION

Clears all log messages including errors on the server

.PARAMETER Connection

A connection object

.EXAMPLE

Clear-IqsLog

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
        Clear-PipLog -Connection $Connection -Method "Delete" -Uri "/api/v1/logging"
    }
    end {}
}
