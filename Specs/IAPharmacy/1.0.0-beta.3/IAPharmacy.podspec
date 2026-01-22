Pod::Spec.new do |s|
  s.name             = 'IAPharmacy'
  s.version          = '1.0.0-beta.3'
  s.summary          = 'Podspec for distributing IAPharmacy.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.3/IAPharmacy-1.0.0-beta.3.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IAPharmacy.xcframework']
  s.dependency 'IACore', '1.0.0-beta.3'
end
