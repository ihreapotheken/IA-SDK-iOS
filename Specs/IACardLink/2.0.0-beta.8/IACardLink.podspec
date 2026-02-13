Pod::Spec.new do |s|
  s.name             = 'IACardLink'
  s.version          = '2.0.0-beta.8'
  s.summary          = 'Podspec for distributing CardLinkSDK.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.8/IACardLink-2.0.0-beta.8.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IACardLink.xcframework']
  s.dependency 'GematikOpenSSL', '4.3.1'
  s.dependency 'IACore', '2.0.0-beta.8'
end
