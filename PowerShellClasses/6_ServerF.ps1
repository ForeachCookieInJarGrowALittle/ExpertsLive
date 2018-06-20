# adding a constructor that accepts a pscustomobjectclass ChangeF {  [String]$Synopsis  [Datetime]$WhenChanged = (get-date)  [String]$ChangedBy = $env:USERNAME  ChangeF ([String]$Synopsis) {  $this.Synopsis = $Synopsis  }  ChangeF([PSCustomObject]$Import) {
    $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
    $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
      $this.$_ = $import.$_
    }
  }}
# adding a constructor that accepts a pscustomobjectClass ServerF {
  static [String] $ServerDataLocation = "C:\Users\Thiros\Dropbox\ExpertsLive\PowerShellClasses\Serverdata"
  [String]$Name
  [String]$Operatingsystem
  [Bool]$IsVirtualMachine
  [Int]$NumberOfCores
  [Int]$RAM_GB
  hidden [ChangeF[]]$ChangeLog
  
  ServerF([String]$Name,[String]$OperatingSystem,[bool]$isVirtualMachine,[int]$NumberOfCores,[int]$RAM_GB) {
    $this.Name = $Name
    $this.Operatingsystem = $OperatingSystem
    $this.IsVirtualMachine = $isVirtualMachine
    $this.NumberOfCores = $NumberOfCores
    $this.RAM_GB = $RAM_GB
  }
  
  ServerF([PSCustomObject]$Import) {
    $staticmember = $this|get-member -Static -MemberType Property|select -ExpandProperty NAme
    $this.gettype().DeclaredProperties.name.where{$_ -notin $staticmember}.foreach{
      $this.$_ = $import.$_
    }
  }
  
  [Void] AddRam([Int]$GB) {
    $this.RAM_GB += $GB
    $this.ChangeLog += [ChangeF]::new("Added $GB of RAM")
  }
  
  [void] AddCores([Int]$Cores) {
    $this.NumberOfCores = $Cores
    $this.ChangeLog += [ChangeF]::new("Added $cores Cores")
  }
  
  [void] SaveToDisk() {
    $this|ConvertTo-Json|Out-File -FilePath (join-path ([ServerF]::ServerDataLocation) $this.Name)
  }
  
  static [ServerF] GetByName([String]$Name) {
    $path = ([ServerF]::ServerDataLocation) + "\$name"
    $json = Get-content $path -ReadCount 0|Out-String
    $pscustomobject = ConvertFrom-Json -InputObject $json
    return [ServerF]::new($pscustomobject)
  }
}

$ServerF1 = [ServerF]::new("ServerF1","Windows Server 2016 Standard",$true,2,16)

$ServerF1

$ServerF1.SafeToDisk

$ServerF2 = [ServerF]::new("ServerF2","Windows Server 2016 Standard",$true,2,16)

$ServerF2

$ServerF2.SaveTODisk()

$RetrievedObjectF1 = [ServerF]::GetByName("ServerF1")

$RetrievedObjectF2 = [ServerF]::GetByName("ServerF2")
