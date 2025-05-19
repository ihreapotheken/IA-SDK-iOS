Pod::Spec.new do |s|
  s.name             = 'GematikOpenSSL'
  s.version          = '4.3.1'
  s.summary          = 'Gematik OpenSSL doesnt have its own pod so we created it for internal usage.'
  s.homepage         = 'https://example.com'
  s.license      = { :type => 'Apache License, Version 2.0', :text => <<-LICENSE
    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
    LICENSE
  }
  s.author           = { 'Gematik' => 'https://example.com' }
  s.source           = { :http => 'https://github.com/gematik/OpenSSL-Swift/releases/download/4.3.1/OpenSSL.xcframework.zip' }
  s.ios.deployment_target = '15.0'

  s.vendored_frameworks = [
    'OpenSSL.xcframework'
  ]
end
