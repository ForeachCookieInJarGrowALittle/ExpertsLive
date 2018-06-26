Class VersionInfo {
    [String]$name
    [Double]$VersionNumber
    
    VersionInfo([String]$InputString) {
      $this.Name = $inputstring -replace '(^[^0-9.]+)(.*)','$1'
      $VersionString = $inputstring -replace '(^[^0-9.]+)(.*)','$2'
      #leading dots will be padded with 0
      if ($VersionString.IndexOf(".") -eq 0) {
        $versionstring = "0$versionString"
      }
      write-verbose $VersionString -verbose
      $this.VersionNumber = (($VersionString.Trim() -replace '^(\d+)\.','$1-').replace('.','').Replace('-','.')) -as [Double]
    }
  }