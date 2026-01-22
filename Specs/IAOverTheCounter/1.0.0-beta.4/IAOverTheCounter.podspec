Pod::Spec.new do |s|
  s.name             = 'IAOverTheCounter'
  s.version          = '1.0.0-beta.4'
  s.summary          = 'Podspec for distributing IAOverTheCounter.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/1.0.0-beta.4/IAOverTheCounter-1.0.0-beta.4.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IAOverTheCounter.xcframework']
  s.dependency 'IACore', '1.0.0-beta.4'
end
