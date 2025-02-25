Pod::Spec.new do |s|
  s.name             = 'IASDK'
  s.version          = '0.0.1'
  s.summary          = 'IASDK'
  s.description      = 'IASDK'
  s.homepage         = 'https://your-homepage.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'you@example.com' }
  s.platform         = :ios, '15.0'
  s.source           = { :git => 'https://dummy-source' }

  s.subspec 'IACore' do |core|
    core.binary = 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.1-beta1/IACore-0.0.1.xcframework.zip'
  end

  s.subspec 'IAOverTheCounter' do |otc|
    otc.binary = 'https://github.com/ihreapotheken/IA-SDK-iOS/releases/download/0.0.1-beta1/IAOverTheCounter-0.0.1.xcframework.zip'
    otc.dependency 'IASDK/IACore'
  end
end