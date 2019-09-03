
function Show-Object {
	<#

	.SYNOPSIS

	Provides a graphical interface to let you explore and navigate an object.


	.EXAMPLE

	PS > $ps = { Get-Process -ID $pid }.Ast
	PS > Show-Object $ps

	#>
	param(
		## The object to examine
		[Parameter(ValueFromPipeline = $true)]
		$InputObject
	)
	& "$PSScriptRoot\Show-Object.ps1" $InputObject
}

Write-Host "Profile includes Show-Object function"