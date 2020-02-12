########################################################
##
## Sessions.ps1
## Management interface to IQuipsys Positron
## Session management commands
##
#######################################################


function Register-IqsUser
{
<#
.SYNOPSIS

Signs up a new user

.DESCRIPTION

Performs signup and opens a new session

.PARAMETER Connection

A connection object

.PARAMETER User

A user info with the following structure
- email: string
- name: string
- login: string
- password: string
- about: string (optional)
- theme: string  (optional)
- language: string (optional)
- theme: string (optional)

.EXAMPLE

Register-IqsUser -User @{ name="Test User"; login="test"; email="test@somewhere.com"; password="test123" }

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [Object] $User
    )
    begin {}
    process 
    {
        $session = Invoke-PipFacade -Connection $Connection -Method "Post" -Route "/api/v1/signup" -Request $User

        $Connection = if ($Connection -eq $null) { Get-PipConnection } else { $Connection }
        if ($Connection -ne $null) {
            $Connection.Headers["x-session-id"] = $session.id
        }
        
        Write-Output $session
    }
    end {}
}


function Open-IqsSession
{
<#
.SYNOPSIS

Opens a new user session with client facade

.DESCRIPTION

Open-IqsSession opens connection and starts a new user session with client facade

.PARAMETER Connection

A connection object

.PARAMETER Login

User login

.PARAMETER Password

User password

.EXAMPLE

$test = Open-IqsSession -Login "test1@somewhere.com" -Password "mypassword"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [string] $Login,
        [Parameter(Mandatory=$true, Position = 5, ValueFromPipelineByPropertyName=$true)]
        [string] $Password
    )
    begin {}
    process 
    {
        $route = "/api/v1/signin"
        $Request = @{
            login = $Login
            password = $Password
        }

        $session = Invoke-PipFacade -Connection $Connection -Method "POST" -Route $route -Request $Request

        $Connection = if ($Connection -eq $null) { Get-PipConnection } else {$Connection}
        if ($Connection -ne $null) {
            $Connection.Headers["x-session-id"] = $session.id
        }
        
        Write-Output $session
    }
    end {}
}


function Close-IqsSession
{
<#
.SYNOPSIS

Closes previously opened user session with client facade

.DESCRIPTION

Open-IqsSession closes previously opened user session with client facade

.PARAMETER Connection

A connection object

.EXAMPLE

Close-IqsSession

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
        $route = "/api/v1/signout"

        $null = Invoke-PipFacade -Connection $Connection -Method "Get" -Route $route

        $Connection = if ($Connection -eq $null) { Get-PipConnection } else { $Connection }
        if ($Connection -ne $null) {
            $Connection.Headers["x-session-id"] = $null
            $Connection.Session = $null
        }
    }
    end {}
}


function Get-IqsSessions
{
<#
.SYNOPSIS

Gets sessions by specified criteria

.DESCRIPTION

Gets a page with sessions that satisfy specified criteria

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

Get-IqsSessions -Take 10

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
        Get-PipSessions -Connection $Connection -Method "Get" -Uri "/api/v1/sessions" -Filter $Filter -Skip $Skip -Take $Take -Total $Total
    }
    end {}
}


function Get-IqsCurrentSession
{
<#
.SYNOPSIS

Gets the current session

.DESCRIPTION

Gets the current session

.PARAMETER Connection

A connection object

.EXAMPLE

Get-IqsCurrentSession

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
        Get-PipCurrentSession -Connection $Connection -Method "Get" -Uri "/api/v1/sessions/current"
    }
    end {}
}
