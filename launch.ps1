﻿$currentPath = Split-Path $MyInvocation.InvocationName

$tabsToCreate = Get-ChildItem -Path $currentPath | ?{ $_.PSIsContainer} | Select-Object FullName, Name

if ($Host.Name -eq 'Windows PowerShell ISE Host') {
    $psise.PowerShellTabs[0].DisplayName = "Tech Talks"
    $psise.CurrentPowerShellTab.Files.Clear() | Out-null
    $psise.CurrentPowerShellTab.Files.Add("$currentPath\README.md") | Out-Null
    foreach ($tabName in $tabsToCreate) {
        $currentTabPath = "$currentPath\$($tabName.Name)"
        $powershellScripts = Get-ChildItem -Path "$currentTabPath\*" -Include *.ps1
        $psise.PowerShellTabs.Add() | Out-Null
        $psise.PowerShellTabs[-1].DisplayName = $tabName.Name
        $psise.PowerShellTabs.SelectedPowerShellTab = $psise.PowerShellTabs[-1]
        foreach ($script in $powershellScripts) {
            $psise.PowerShellTabs[-1].Files.Add($script.FullName) | Out-Null
        }
    }
    $psise.PowerShellTabs.SelectedPowerShellTab = $psise.PowerShellTabs[0]
} else {
    PowerShell_ise.exe -file $MyInvocation.ScriptName
}