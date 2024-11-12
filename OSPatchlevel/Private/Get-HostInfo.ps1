function Get-HostInfo {
    [CmdLetBinding()]
    param (
        [Parameter(
            Mandatory = $true,
            Position = 0
        )]
        [String] $SytemInfoCSV
    )

    $CSVHeader = "HostName", "OSName", "OSVersion", "OSManufacturer", "OSConfiguration", "OSBuildType", "RegisteredOwner", "RegisteredOrganization", "ProductID", "OriginalInstallDate", "SystemBootTime", "SystemManufacturer", "SystemModel", "SystemType", "Processors", "BIOSVersion", "WindowsDirectory", "SystemDirectory", "BootDevice", "SystemLocale", "InputLocale", "TimeZone", "TotalPhysicalMemory", "AvailablePhysicalMemory", "VirtualMemoryMaxSize", "VirtualMemoryAvailable", "VirtualMemoryInUse", "PageFileLocation", "Domain", "LogonServer", "Hotfixes", "NetworkCards", "HyperVRequirements"

    $Encoding = Get-FileEncoding $SytemInfoCSV
    $CSVContent = @(Import-Csv $SytemInfoCSV -Header $CSVHeader  -Encoding $Encoding | Select-Object -Skip 1)

    $HostList = @()
    ForEach ($Line in $CSVContent) {
        $HostList += [Host]::new($Line)
    }
}


