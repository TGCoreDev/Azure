<#
.DESCRIPTION
    Sets regional settings on Azure Virtual Machine deployed from the marketplace.

.NOTES
    Author:     Tom Gwyther | Core
    Version:    1.0
    Version History:
        1.0 -   Initial release
#>

#variables
$regionalsettingsURL = "https://raw.githubusercontent.com/TGCoreDev/Azure/main/ServerBuild/GBRegion.xml"
$RegionalSettings = "D:\GBRegion.xml"


#downdload regional settings file
$webclient = New-Object System.Net.WebClient
$webclient.DownloadFile($regionalsettingsURL,$RegionalSettings)


# Set Locale, language etc. 
& $env:SystemRoot\System32\control.exe "intl.cpl,,/f:`"$RegionalSettings`""

# Set languages/culture. Not needed perse.
Set-WinSystemLocale en-GB
Set-WinUserLanguageList -LanguageList en-GB -Force
Set-Culture -CultureInfo en-GB
Set-WinHomeLocation -GeoId 242
Set-TimeZone -Name "GMT Standard Time"

# restart virtual machine to apply regional settings to current user. You could also do a logoff and login.
Start-sleep -Seconds 40
Restart-Computer