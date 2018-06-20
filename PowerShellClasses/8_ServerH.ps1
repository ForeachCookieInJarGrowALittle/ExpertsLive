﻿class ChangeH : IComparable {
    $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
    $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
      $this.$_ = $import.$_
    }
  }
      $isEqual = 0
        if ($this.$_ -ne $object.$_) {
          write-verbose $_ -verbose
          $isEqual = -1
        }
      }
Class ServerH : IComparable {
  static [String] $ServerDataLocation = "C:\Users\Thiros\Dropbox\ExpertsLive\PowerShellClasses\Serverdata"
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB
  hidden [ChangeH[]]$ChangeLog
  
  ServerH([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
  
  ServerH([PSCustomObject]$Import) {
    $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
    $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
      $this.$_ = $import.$_
    }
  }
  
  [int] CompareTo([Object]$Object) {
      $isEqual = 0
        if ($this.$_ -ne $object.$_) {
          write-verbose $_ -verbose
          $isEqual = -1
        }
      }
  [String] ToString() {
  
  [Void] AddRam([Int]$GB) {
    $this.RAM_GB += $GB
    $this.ChangeLog += [ChangeH]::new("Added $GB of RAM")
  }
  
  [void] AddCores([Int]$Cores) {
    $this.NumberOfCores = $Cores
    $this.ChangeLog += [ChangeH]::new("Added $cores Cores")
  }
  
  [void] SaveToDisk() {
    $this|export-clixml -Path (join-path ([ServerH]::ServerDataLocation) $this.Name)
  }
  
  static [ServerH] GetByName([String]$Name) {
    $path = ([ServerH]::ServerDataLocation) + "\$name"
    $pscustomobject = Import-Clixml -Path $path
    return [ServerH]::new($pscustomobject)
  }
  
  [String] Tostring() {
    return $this.Name
  }
}

$ServerH = [ServerH]::new("ServerH","Windows Server 2016 Standard",$true,2,16)

$ServerH.SaveTODisk()

$RetrievedObjectH = [ServerH]::GetByName("ServerH")

Compare-Object $ServerH $RetrievedObjectH -IncludeEqual

$ServerH.name = "ServerH1"
Compare-Object $ServerH $RetrievedObjectH -IncludeEqual


$ServerH.AddCores(4)

$ServerH.SaveTODisk()

$RetrievedObjectH = [ServerH]::GetByName("ServerH")

Compare-Object $ServerH $RetrievedObjectH -IncludeEqual
