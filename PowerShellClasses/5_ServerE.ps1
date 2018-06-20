# Same simple class for modelling changelog entriesclass ChangeE {[String]$Synopsis[Datetime]$WhenChanged = (get-date)[String]$ChangedBy = $env:USERNAMEChangeE ([String]$Synopsis) {$this.Synopsis = $Synopsis}}
# properties and methods are either bound to a specific instance of a class,
# or the class itself, and are available without instantiating the class
# this is achieved by using the non-access modifier static
Class ServerE {
  static [String] $ServerDataLocation = "C:\Users\Thiros\Dropbox\ExpertsLive\PowerShellClasses\Serverdata"
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB
  hidden [ChangeE[]]$ChangeLog
  
  ServerE([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
  
  [Void] AddRam([Int]$GB) {
    $this.RAM_GB += $GB
    $this.ChangeLog += [ChangeE]::new("Added $GB of RAM")
  }
  
  [void] AddCores([Int]$Cores) {
    $this.NumberOfCores = $Cores
    $this.ChangeLog += [ChangeE]::new("Added $cores Cores")
  }
  
  # converting the object to JSON and saving it to disk
  
  [void] SaveToDisk() {
    $this|ConvertTo-Json|Out-File -FilePath (join-path ([ServerE]::ServerDataLocation) $this.Name)
  }
}

[ServerE]::ServerDataLocation

# Change the value of the static property
[ServerE]::ServerDataLocation = "C:\temp"

# Create an instance and save to disk
$ServerE = [ServerE]::new("ServerE","Windows Server 2016 Standard",$true,2,16)
$ServerE.SaveTODisk()


# retrieve saved data
$RetrievedObjectE = get-content (join-path ([ServerE]::ServerDataLocation) "ServerE")|ConvertFrom-Json
$RetrievedObjectE.Gettype().fullname

# try clixml
$serverE|Export-Clixml C:\temp\ServerE.xml
$serverEImport = Import-Clixml C:\temp\ServerE.xml
$serverEImport.GetType().fullname

# takeaway: reimporting saved data results in a deserialized object
$serverEImport.psobject.TypeNames

# implicit casting of the object does not work, because there is no constructor accepting a pscustomobject as input
[ServerE]$RetrievedObjectE