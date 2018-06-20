# You can even implement Interfaces even though they might not always behave the way you expect it toclass ChangeG : IComparable {  [String]$Synopsis  [Datetime]$WhenChanged = (get-date)  [String]$ChangedBy = $env:USERNAME  ChangeG ([String]$Synopsis) {  $this.Synopsis = $Synopsis  }  ChangeG([PSCustomObject]$Import) {
    $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
    $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
      $this.$_ = $import.$_
    }
  }  [int] CompareTo([Object]$Object) {    if ($Object.GetType().fullname -eq $this.Gettype().fullname) {      $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
      $isEqual = 0      $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
        if ($this.$_ -ne $object.$_) {
          write-verbose $_ -verbose
          $isEqual = -1
        }
      }      if ($this.WhenChanged -lt $Object.whenchanged) {      $isEqual = 1      }    } else {    throw "Cannot compare to $($Object.GetType().fullname)"    }    return $isEqual  }}
Class ServerG : IComparable {
  static [String] $ServerDataLocation = "C:\Users\Thiros\Dropbox\ExpertsLive\PowerShellClasses\Serverdata"
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB
  hidden [ChangeG[]]$ChangeLog
  
  ServerG([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
  
  ServerG([PSCustomObject]$Import) {
    $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
    $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
      $this.$_ = $import.$_
    }
  }
  
  [int] CompareTo([Object]$Object) {    if ($Object.GetType().fullname -eq $this.Gettype().fullname) {      $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
      $isEqual = 0      $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
        if ($this.$_ -ne $object.$_) {
          write-verbose $_ -verbose
          $isEqual = -1
        }
      }      if ($this.Name -lt $Object.Name) {      $isEqual = 1      }    } else {    throw "Cannot compare to $($Object.GetType().fullname)"    }    return $isEqual  }
  
  
  [Void] AddRam([Int]$GB) {
    $this.RAM_GB += $GB
    $this.ChangeLog += [ChangeG]::new("Added $GB of RAM")
  }
  
  [void] AddCores([Int]$Cores) {
    $this.NumberOfCores = $Cores
    $this.ChangeLog += [ChangeG]::new("Added $cores Cores")
  }
  
  [void] SaveToDisk() {
    $this|export-clixml -Path (join-path ([ServerG]::ServerDataLocation) $this.Name)
  }
  
  static [ServerG] GetByName([String]$Name) {
    $path = ([ServerG]::ServerDataLocation) + "\$name"
    $pscustomobject = Import-Clixml -Path $path
    return [ServerG]::new($pscustomobject)
  }
}

$ServerG = [ServerG]::new("ServerG","Windows Server 2016 Standard",$true,2,16)

$ServerG.SaveTODisk()

$RetrievedObjectG = [ServerG]::GetByName("ServerG")

Compare-Object $ServerG $RetrievedObjectG -IncludeEqual

$ServerG.name = "ServerG1"
Compare-Object $ServerG $RetrievedObjectG -IncludeEqual
