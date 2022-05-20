#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint moment_ali_real_authentication.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'moment_ali_real_authentication'
  s.version          = '0.0.1'
  s.summary          = '支付宝人脸认证插件'
  s.description      = <<-DESC
支付宝人脸认证插件
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.'}

  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '10.0'
  s.dependency 'AntVerify'
#  :git => "https://code.aliyun.com/mpaas-public/podspecs.git"
  
  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
end
