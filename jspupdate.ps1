$scriptsDir = "c:\workload\scripts"
$localJSP = Get-ChildItem $scriptsDir -Include JobSortPlus.py -Recurse
$update = "path redacted for security"
$netPathGood = Test-Path $update
  
try {
  if ($localJSP -and $netPathGood) {
    Write-Output "Local install and remote path checked. Starting update process..."
    Start-Process $update -PassThru
    $exit = $LASTEXITCODE
    Write-Output "Completed. Exit Code: $exit"
    Exit $exit
  } elseif (! $localJSP) {
    Write-Error "Problem with JSP installation on this machine. JobSortPlus.py not found in $scriptsDir"
    Exit 1
  } elseif (! $netPathGood) {
    Write-Error "I don't have access to the network path to fetch the JSP updater."
    Exit 1
  }
} catch {
  Write-Error $Error
}
