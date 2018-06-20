# Same simple class definition, but with a more convenient way of creating
# an instance
Class ServerB {
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB 
  
  ServerB([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
}

# As soon as you declare a Constructor yourself
# the default parameterless new() Constructor is not available anymore
$serverB = [ServerB]::new()

# instead we now use the newly defined constructor passing in all required aguments
$ServerB = [serverB]::new("ServerB","Windows Server 2016 Standard",$true,2,16)

$serverB