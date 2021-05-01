#
# Be sure to run `pod lib lint AnyRouter.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnyRouter'
  s.version          = '0.0.1'
  s.summary          = '基于路有的通用模块间通信方案.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
通用模块间通信方案；可用于通用的数据通信，也可用于UI页面通信。
                       DESC

  s.homepage         = 'https://gitee.com/hsh/any-router'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'hsh' => 'qinyue0306@163.com' }
  s.source           = { :git => 'https://gitee.com/hsh/any-router.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'
  s.swift_version         = "5.0"
  
  s.subspec 'Core' do |ss|
    ss.source_files = 'AnyRouter/Classes/Core/**/*.swift'
  end
  s.subspec 'Loader' do |ss|
    ss.source_files = 'AnyRouter/Classes/Loader/**/*.swift'
    ss.dependency 'AnyRouter/Core'
  end
  
  # s.resource_bundles = {
  #   'AnyRouter' => ['AnyRouter/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
