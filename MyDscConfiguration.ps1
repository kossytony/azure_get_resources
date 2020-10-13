Configuration MyDscConfiguration {
    Node "localhost" {
      WindowsFeature MyFeatureInstance {
        Ensure = 'Present'
        Name = 'Web-Server'
      }
    }
  }