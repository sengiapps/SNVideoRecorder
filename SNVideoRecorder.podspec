#
# Be sure to run `pod lib lint SNVideoRecorder.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SNVideoRecorder'
  s.version          = '0.1.0'
  s.summary          = 'A WhatsApp-like video recorder.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A WhatsApp-like video recorder view controller.
                       DESC

  s.homepage         = 'https://github.com/dairdr/SNVideoRecorder'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Dair Diaz' => 'dair.diaz@sengiapps.co' }
  s.source           = { :git => 'https://github.com/dairdr/SNVideoRecorder.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/dairdr'

  s.ios.deployment_target = '9.0'

  s.source_files = 'SNVideoRecorder/Classes/**/*'
  
  s.resource_bundles = {
    'SNVideoRecorder' => ['SNVideoRecorder/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'AVFoundation'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'NVActivityIndicatorView'
end
