# Another simple class to model the structure of a change-entryclass ChangeD {[String]$Synopsis[Datetime]$WhenChanged = (get-date)[String]$ChangedBy = $env:USERNAMEChangeD ([String]$Synopsis) {$this.Synopsis = $Synopsis}}

# Properties and Methods by default are assigned the public access modifier
# The second modifier available is hidden
Class ServerD {
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB
  hidden [ChangeD[]]$ChangeLog
  
  ServerD([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
  
  [Void] AddRam([Int]$GB) {
    $this.RAM_GB += $GB
    $this.ChangeLog += [ChangeD]::new("Added $GB of RAM")
    
  }
  
  hidden [void] AddCores([Int]$Cores) {
    $this.NumberOfCores += $Cores
    $this.ChangeLog += [ChangeD]::new("Added $cores Cores")
  }
}
# create an instance of the class
$ServerD = [ServerD]::new("ServerD","Windows Server 2016 Standard",$true,2,16)

# notice, how you dont see the ChangeLog property
$ServerD
# the properties is ommited by default when displaying the members
$ServerD|get-member -MemberType Properties
$ServerD|get-member -MemberType Method
# to include it in the output of get-member you have to use the force
$ServerD|get-member -MemberType Properties -Force
$ServerD|get-member -MemberType Method -Force

# Creating new changelog entries
$ServerD.AddRam(16)
$ServerD.AddCores(2)

# If you know the property's name you can still read it
$serverD.Changelog

# or even write to it
$ServerD.Changelog += [ChangeD]::new("reboot")
$ServerD.Changelog
