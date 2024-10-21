Start-Transcript -Path C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Remediations\Detect-WindowsActivation.log -Append

# Get Windows License Status Code
$licenseStatusCode = (Get-CimInstance -ClassName SoftwareLicensingProduct | Where-Object {$_.PartialProductKey}).LicenseStatus

# Windows is only activated if the code is 0
if($licenseStatusCode -ne 1){
    Write-Output "Windows is not activated."
    Stop-Transcript
    exit -1
}
else{
    Write-Output "Windows is activated."
    Stop-Transcript
    exit 0
}

