#
# Be sure to run `pod lib lint Sailor.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Sailor'
  s.version          = '0.1.0'
  s.summary          = 'A navigation manager for iOS'
  s.swift_version    = '4.1'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Sailor is a navigaton manager. It provides subclasses of common navigation UI controllers to support routes.
                       DESC

  s.homepage         = 'https://github.com/oscarvgg/Sailor'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '@oscarvgg' => 'https://twitter.com/oscarvgg' }
  s.source           = { :git => 'https://github.com/oscarvgg/Sailor.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/oscarvgg'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sailor/Classes/**/*'
  
  # s.resource_bundles = {
  #   'Sailor' => ['Sailor/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
