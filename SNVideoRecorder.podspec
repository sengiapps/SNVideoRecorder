Pod::Spec.new do |s|
  s.name             = 'SNVideoRecorder'
  s.version          = '0.2.2'
  s.summary          = 'A WhatsApp-like video recorder.'
  s.description      = 'A WhatsApp-like video recorder view controller and photo capture.'
  s.homepage         = 'https://github.com/dairdr/SNVideoRecorder'
  # s.screenshots      = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dair Diaz' => 'dair.diaz@sengiapps.co' }
  s.source           = { :git => 'https://github.com/dairdr/SNVideoRecorder.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/dairdr'
  s.ios.deployment_target = '9.0'
  s.source_files = 'SNVideoRecorder/Classes/**/*'
  #s.resource_bundles = {
  #  'SNVideoRecorder' => ['SNVideoRecorder/Assets/*.png']
  #}
  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'NVActivityIndicatorView'
end
