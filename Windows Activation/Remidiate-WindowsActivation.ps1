Start-Transcript -Path C:\ProgramData\Microsoft\IntuneManagementExtension\Logs\Remediations\Remidiate-WindowsActivation.log -Append

$MAKKey = "" #Fill in the value here if you want to use a MAK key to activate. If empty, motherboard key will be used.

$activationKey = ""

if($MAKKey -eq ""){
    Write-Output "Activating Windows with Motherboard Key"
    $activationKey = (Get-CimInstance -Query 'select * from SoftwareLicensingService').OA3xOriginalProductKey
}
else{
    Write-Output "Activating Windows with MAK Key"
    $activationKey = $MAKKey
}

try{
    Write-Output "Key used: $activationKey"
    slmgr.vbs /ipk $activationKey
    slmgr.vbs /ato
    Write-Output "Windows Activation attempt complete!"
}
catch{
    Write-Output "Windows could not successfully activate: $($_.Exception.Message)"
}
Stop-Transcript