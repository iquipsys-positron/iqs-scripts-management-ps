########################################################
##
## Connections.ps1
## Management interface to IQuipsys Positron
## Facade connection commands
##
#######################################################


function Connect-IqsFacade
{
<#
.SYNOPSIS

Opens a new connection with client facade

.DESCRIPTION

Open-IqsConnection opens a new connection with client facade

.PARAMETER Name

A name to refer to the client facade

.PARAMETER Host

A facade connection protocol (default: http)

.PARAMETER Host

A facade hostname or IP address

.PARAMETER Port

A facade port to access the cluster (default: 80)

.PARAMETER Login

User login

.PARAMETER Password

User password

.EXAMPLE

$test = Connect-IqsFacade -Host "172.16.141.175" -Post 28800 -Login "test1@somewhere.com" -Password "password123"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Name = "default",
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string] $Protocol = "http",
        [Parameter(Mandatory=$true, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $Host,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [int] $Port = 80,
        [Parameter(Mandatory=$true, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [string] $Login,
        [Parameter(Mandatory=$true, Position = 5, ValueFromPipelineByPropertyName=$true)]
        [string] $Password
    )
    begin {}
    process 
    {
        $connection = Open-PipConnection -Protocol $Protocol -Host $Host -Port $Port
        $session = Open-IqsSession -Connection $connection -Login $Login -Password $Password
        $connection.Session = $session
        Write-Output $connection
    }
    end {}
}


function Disconnect-IqsFacade
{
<#
.SYNOPSIS

Closes previously opened user session and disconnects from client facade

.DESCRIPTION

Disconnect-IqsFacade closes previously opened user session and disconnects client facade

.PARAMETER Connection

A connection object

.PARAMETER Name

A name to refer to the client facade

.EXAMPLE

Disconnect-IqsFacade

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $Name
    )
    begin {}
    process 
    {
        $null = Close-IqsSession -Connection $Connection
        $null = Close-PipConnection -Connection $Connection
    }
    end {}
}