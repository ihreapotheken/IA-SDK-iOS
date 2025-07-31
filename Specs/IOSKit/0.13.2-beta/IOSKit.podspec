Pod::Spec.new do |s|
  s.name             = 'IOSKit'
  s.version          = '0.13.2-beta'
  s.summary          = 'Podspec for distributing IOSKit.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.13.2-beta/IOSKit-0.13.2-beta.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IOSKit.xcframework']
end