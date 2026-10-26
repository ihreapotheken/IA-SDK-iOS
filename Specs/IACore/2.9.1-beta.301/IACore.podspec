Pod::Spec.new do |s|
  s.name             = 'IACore'
  s.version          = '2.9.1-beta.301'
  s.summary          = 'Podspec for distributing IACore.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.9.1-beta.301/IACore-2.9.1-beta.301.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IACore.xcframework']
  s.dependency 'IOSKit', '2.9.1-beta.301'
end