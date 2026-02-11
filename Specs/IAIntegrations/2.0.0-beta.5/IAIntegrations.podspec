Pod::Spec.new do |s|
  s.name             = 'IAIntegrations'
  s.version          = '2.0.0-beta.5'
  s.summary          = 'Podspec for distributing IAIntegrations.'
  s.homepage         = 'https://4ofthem.eu/'
  s.license          = { :type => 'MIT' }
  s.author           = { 'Four of them LLC' => 'https://4ofthem.eu/' }
  s.source           = { :http => 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/2.0.0-beta.5/IAIntegrations-2.0.0-beta.5.xcframework.zip' }
  s.ios.deployment_target = '15.0'
  s.vendored_frameworks = ['IAIntegrations.xcframework']
  s.dependency 'IACore', '2.0.0-beta.5'
end
