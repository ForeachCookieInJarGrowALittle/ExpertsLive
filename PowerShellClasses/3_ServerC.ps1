# Adding our first methods to increase Ram and NumberOfCores
Class ServerC {
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB 
  
  ServerC([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
  
  [Void] AddRam([Int]$GB) {
    $this.RAM_GB += $GB
  }
  
  [void] AddCores([Int]$Cores) {
    $this.NumberOfCores = $Cores
  }
  
  
}

$ServerC = [ServerC]::new("ServerC","Windows Server 2016 Standard",$true,2,16)

$serverC

$serverC.AddRam(16)
$serverC.AddCores(2)

$serverC