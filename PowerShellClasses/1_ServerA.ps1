# Just a simple class definition to model some basic data for a Server
Class ServerA {
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB
}

# if the class has no constructors defined, the default constructor provides an instance
# with all properties set to the default value of the type bound to that property
$ServerA = [serverA]::new()

# that is empty strings, Zeros and false for boolean types
$serverA

# you then would have to set the values yourself
$ServerA.Name = "ServerA"
$ServerA.Operatingsystem = "Windows Server 2016 Standard"
$ServerA.IsVirtualMachine = $true
$ServerA.NumberOfCores = 2
$ServerA.RAM_GB = 16

# resulting in
$ServerA