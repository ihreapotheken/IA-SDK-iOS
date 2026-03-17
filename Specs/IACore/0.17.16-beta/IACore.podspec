Pod::Spec.new do |s|
  s.name             = 'IACore'
  s.version          = '0.17.16-beta'
  s.summary          = 'Podspec for distributing IACore.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.17.16-beta/IACore-0.17.16-beta.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IACore.xcframework']
  s.dependency 'IOSKit', '0.17.16-beta'
end