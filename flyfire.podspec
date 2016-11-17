Pod::Spec.new do |s|
  s.name         = "flyfire"
  s.version      = "0.1.7"
  s.summary      = "WebSocket (RFC 6455) client library for iOS & OS X - PKCS #12 Client Certificate"
  s.homepage     = "https://github.com/flynetworks/jetfire"
  s.license      = 'Apache License, Version 2.0'
  s.author       = { "Dalton Cherry" => "daltoniam@gmail.com", "Kay Schecker" => "github@flynetworks.de" }
  s.social_media_url = 'http://twitter.com/daltoniam'
  s.source       = { :git => "https://github.com/flynetworks/jetfire.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
