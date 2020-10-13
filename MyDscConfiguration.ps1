Configuration MyDscConfiguration {
  [CmdletBinding()]
  param (
      [Parameter()]
      [string]
      $ParameterName
  )
    Node "localhost" {
      WindowsFeature MyFeatureInstance {
        Ensure = 'Present'
        Name = 'Web-Server'
      }
    }
  }