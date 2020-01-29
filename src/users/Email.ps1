########################################################
##
## Email.ps1
## Management interface to IQuipsys Positron
## Email commands
##
#######################################################

function Send-IqsEmail
{
<#
.SYNOPSIS

Requests email message to arbitrary address

.DESCRIPTION

Requests email message to arbitrary address

.PARAMETER Connection

A connection object

.PARAMETER Message

Message object with the following fields:
- from: string
- to: string
- cc: string
- subject: string
- text: string
- html: string

.PARAMETER Recipient

Optional recipient identified who is a system user

.EXAMPLE

Send-IqsEmail -Message @{ to="somebody@somewhere.com"; subject="Test"; text="This is a test email" }

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
        Send-PipEmail -Connection $Connection -Method "Post" -Uri "/api/v1/email" -Message $Message -Recipient $Recipient
    }
    end {}
}
