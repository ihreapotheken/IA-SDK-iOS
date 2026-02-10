Pod::Spec.new do |s|
  s.name             = 'IAPharmacy'
  s.version          = '2.0.1-beta.1'
  s.summary          = 'Podspec for distributing IAPharmacy.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.1-beta.1/IAPharmacy-2.0.1-beta.1.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IAPharmacy.xcframework']
  s.dependency 'IACore', '2.0.1-beta.1'
end
