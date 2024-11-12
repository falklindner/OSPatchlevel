class Host {

    [string] $HostName
    [string] $OSName
    [string] $OSVersion
    [string] $OSManufacturer
    [string] $OSConfiguration
    [string] $OSBuildType
    [string] $RegisteredOwner
    [string] $RegisteredOrganization
    [string] $ProductID
    [string] $OriginalInstallDate
    [string] $SystemBootTime
    [string] $SystemManufacturer
    [string] $SystemModel
    [string] $SystemType
    [string[]] $Processors
    [string] $BIOSVersion
    [string] $WindowsDirectory
    [string] $SystemDirectory
    [string] $BootDevice
    [string] $SystemLocale
    [string] $InputLocale
    [string] $TimeZone
    [string] $TotalPhysicalMemory
    [string] $AvailablePhysicalMemory
    [string] $VirtualMemoryMaxSize
    [string] $VirtualMemoryAvailable
    [string] $VirtualMemoryInUse
    [string] $PageFileLocation
    [string] $Domain
    [string] $LogonServer
    [string[]] $Hotfixes
    [string[]] $NetworkCards
    [string] $HyperVRequirements


    Host() {}

    Host($HostInfo) {
        
        $this.HostName = $HostInfo.HostName
        $this.OSName = $HostInfo.OSName
        $this.OSVersion = $HostInfo.OSVersion
        $this.OSManufacturer = $HostInfo.OSManufacturer
        $this.OSConfiguration = $HostInfo.OSConfiguration
        $this.OSBuildType = $HostInfo.OSBuildType
        $this.RegisteredOwner = $HostInfo.RegisteredOwner
        $this.RegisteredOrganization = $HostInfo.RegisteredOrganization
        $this.ProductID = $HostInfo.ProductID
        $this.OriginalInstallDate =  $HostInfo.OriginalInstallDate
        $this.SystemBootTime = $HostInfo.SystemBootTime
        $this.SystemManufacturer = $HostInfo.SystemManufacturer
        $this.SystemModel = $HostInfo.SystemModel
        $this.SystemType = $HostInfo.SystemType
        $this.Processors =  $this.ParseToList($HostInfo.Processors, 1)
        $this.BIOSVersion = $HostInfo.BIOSVersion
        $this.WindowsDirectory = $HostInfo.WindowsDirectory
        $this.SystemDirectory = $HostInfo.SystemDirectory
        $this.BootDevice = $HostInfo.BootDevice
        $this.SystemLocale = $HostInfo.SystemLocale
        $this.InputLocale = $HostInfo.InputLocale
        $this.TimeZone = $HostInfo.TimeZone
        $this.TotalPhysicalMemory = $HostInfo.TotalPhysicalMemory
        $this.AvailablePhysicalMemory = $HostInfo.AvailablePhysicalMemory
        $this.VirtualMemoryMaxSize = $HostInfo.VirtualMemoryMaxSize
        $this.VirtualMemoryAvailable = $HostInfo.VirtualMemoryAvailable
        $this.VirtualMemoryInUse = $HostInfo.VirtualMemoryInUse
        $this.PageFileLocation =  $HostInfo.PageFileLocation
        $this.Domain = $HostInfo.Domain
        $this.LogonServer = $HostInfo.LogonServer
        $this.Hotfixes =  $this.ParseToList($HostInfo.Hotfixes, 1)
        $this.NetworkCards = $this.ParseToList($HostInfo.NetworkCards, 1)
        $this.HyperVRequirements = $HostInfo.HyperVRequirements
        
    }

    [string[]] ParseToList ([string] $ListString, [int] $SkippedLines=1) {
        $InitialList = $ListString.split(",")
        if ($SkippedLines -ge $InitialList.Count) {
            $ReturnList=@() 
        } else {
            $List = $InitialList[$SkippedLines..($InitialList.Length-1)]
            $ReturnList=@()
            ForEach ($Item in $List) { 
                try {
                    $ParsedItem = $Item.split(":")[1].trim()
                    $ReturnList += $ParsedItem
                }
                catch {
                    $ReturnList += $Item
                }
            }
        }
        return $ReturnList
    }

    
}
    

    

