########################################################
##
## Blobs.ps1
## Management interface to IQuipsys Positron
## Blob storage commands
##
#######################################################

function Get-IqsBlobs 
{
<#
.SYNOPSIS

Gets list of blobs

.DESCRIPTION

Gets a page of blocks headers

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

Get-IqsBlobs

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
        Get-PipBlobs -Connection $Connection -Method "Get" -Uri "/api/v1/blobs" -Filter $Filter -Skip $Skip -Take $Take
    }
    end {}
}


function Get-IqsBlob
{
<#
.SYNOPSIS

Gets a blob by its unique id

.DESCRIPTION

Gets header for a single blob by its unique id

.PARAMETER Connection

A connection object

.PARAMETER Id

A blob id

.EXAMPLE

Get-IqsBlob -Id 123

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
        Get-PipBlob -Connection $Connection -Method "Put" -Uri "/api/v1/blobs/{0}/info" -Id $Id
    }
    end {}
}


function Update-IqsBlob
{
<#
.SYNOPSIS

Updates blob header

.DESCRIPTION

Updates selected blob header fields

.PARAMETER Connection

A connection object

.PARAMETER Id

A blob id

.PARAMETER Group

A blob group

.PARAMETER File

A blob file name

.PARAMETER Completed

A completed flag (default: False)

.PARAMETER Expire

A blob expiration time (default: no expiration)

.EXAMPLE

Update-IqsBlob -Id 234 -Group test -Completed $false

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$false, Position = 1, ValueFromPipelineByPropertyName=$true)]
        [string] $Group,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [string] $File,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [bool] $Completed,
        [Parameter(Mandatory=$false, Position = 4, ValueFromPipelineByPropertyName=$true)]
        [object] $Expire
    )
    begin {}
    process 
    {
        Update-PipBlob -Connection $Connection -Method "Put" -Uri "/api/v1/blobs/{0}/info" -Id $Id -Group $Group -File $File -Completed $Completed -Expire $Expire
    }
    end {}
}


function Read-IqsBlob
{
<#
.SYNOPSIS

Reads blob by id

.DESCRIPTION

Reads content of a blob identified by id

.PARAMETER Connection

A connection object

.PARAMETER Id

A blob id

.PARAMETER OutFile

Optional file name to write the blob to

.EXAMPLE

Read-IqsBlob -Id "123" -OutFile temp123.dat

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$true, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id,
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [string] $OutFile
    )
    begin {}
    process 
    {
        Read-PipBlob -Connection $Connection -Method "Put" -Uri "/api/v1/blobs/{0}" -Id $Id -OutFile $OutFile
    }
    end {}
}


function Write-IqsBlob
{
<#
.SYNOPSIS

Writes a new blob

.DESCRIPTION

Creates a new blob and loads file as its content

.PARAMETER Connection

A connection object

.PARAMETER Group

A blob group

.PARAMETER Completed

A completed flag (default: False)

.PARAMETER Expire

A blob expiration time (default: no expiration)

.PARAMETER InFile

A name of the file to read from

.EXAMPLE

Write-IqsBlob -Group test -InFile photo.jpg

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$false, Position = 0, ValueFromPipelineByPropertyName=$true)]
        [string] $Group,
        [Parameter(Mandatory=$true, Position = 1, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $InFile,
        [Parameter(Mandatory=$false, Position = 2, ValueFromPipelineByPropertyName=$true)]
        [switch] $Completed,
        [Parameter(Mandatory=$false, Position = 3, ValueFromPipelineByPropertyName=$true)]
        [object] $Expire
    )
    begin {}
    process 
    {
        Write-PipBlob -Connection $Connection -Method "Post" -Uri "/api/v1/blobs" -Group $Group -InFile $InFile -Completed $Completed -Expire $Expire
    }
    end {}
}


function Remove-IqsBlob
{
<#
.SYNOPSIS

Removes blob by its id

.DESCRIPTION

Removes blob identified by id

.PARAMETER Connection

A connection object

.PARAMETER Id

A blob id

.EXAMPLE

Remove-IqsBlob -Id "123"

#>
    [CmdletBinding()]
    param
    (
        [Parameter(Mandatory=$false, ValueFromPipelineByPropertyName=$true)]
        [Hashtable] $Connection,
        [Parameter(Mandatory=$True, Position = 0, ValueFromPipeline=$true, ValueFromPipelineByPropertyName=$true)]
        [string] $Id
    )
    begin {}
    process 
    {
        Remove-PipBlob -Connection $Connection -Method "Delete" -Uri "/api/v1/blobs/{0}" -Id $Id
    }
    end {}
}
