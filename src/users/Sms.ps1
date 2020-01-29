########################################################
##
## Sms.ps1
## Management interface to IQuipsys Positron
## Sms commands
##
#######################################################

function Send-IqsSms
{
<#
.SYNOPSIS

Requests sms message to arbitrary address

.DESCRIPTION

Requests sms message to arbitrary address

.PARAMETER Connection

A connection object

.PARAMETER Message

Message object with the following fields:
- from: string
- to: string
- text: string

.PARAMETER Recipient

Optional recipient identified who is a system user

.EXAMPLE

Send-IqsSms -Message @{ to="+79102342938"; text="This is a test sms" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $Message,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [Object] $Recipient
    )
    begin {}
    process 
    {
        Send-PipSms -Connection $Connection -Method "Post" -Uri "/api/v1/sms" -Message $Message -Recipient $Recipient
    }
    end {}
}
