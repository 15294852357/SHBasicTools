#
# Be sure to run `pod lib lint SHBasicTools.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SHBasicTools'
  s.version          = '1.0.1'
  s.summary          = 'A short description of SHBasicTools.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  #s.homepage         = 'https://github.com/15294852357/SHBasicTools'
  s.homepage         = 'https://gitee.com/BenGongLueMeng/SHBasicTools.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'yangsh' => '15294852357@163.com' }
  #s.source           = { :git => 'https://github.com/15294852357/SHBasicTools.git', :tag => s.version.to_s }
   s.source           = { :git => 'https://gitee.com/BenGongLueMeng/SHBasicTools.git', :tag => s.version.to_s }

  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'SHBasicTools/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SHBasicTools' => ['SHBasicTools/Assets/*.png']
  # }

   #s.public_header_files = 'Pod/Classes/**/*.h'
    s.public_header_files = 'SHBasicTools/Classes/Header.h'

   #默认是true cocoapos会生成默认前缀.pch文件
  s.prefix_header_file = false
  s.prefix_header_file = 'SHBasicTools/Classes/PrefixHeader.pch'
  
   #向pod项目的前缀文件中添加内容
  #s.prefix_header_contents = '#import <AFNetworking/AFNetworking.h>','#import "Masonry/Masonry.h"','#import <SDWebImage/SDWebImage.h>','#import <PGDatePicker/PGDatePickManager.h>'
  
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking'
  s.dependency 'Masonry'
  s.dependency 'MBProgressHUD'
  s.dependency 'SocketRocket'
  s.dependency 'PGDatePicker'
  s.dependency 'SDWebImage'
  s.dependency 'MJExtension'
  s.dependency 'MJRefresh'
  s.dependency 'DZNEmptyDataSet'
  s.dependency 'IQKeyboardManager'
  s.dependency 'JXCategoryView'
  s.dependency 'PrintBeautifulLog'

end
