Pod::Spec.new do |s|
  s.name             = 'IACardLink'
  s.version          = '1.0.0-beta.2'
  s.summary          = 'Podspec for distributing CardLinkSDK.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.2/IACardLink-1.0.0-beta.2.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IACardLink.xcframework']
  s.dependency 'GematikOpenSSL', '4.3.1'
  s.dependency 'IACore', '1.0.0-beta.2'
end
