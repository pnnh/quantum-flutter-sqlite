#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint quantum.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'quantum'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'xspanni@gmail.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.dependency 'FlutterMacOS'

  s.platform = :osx, '10.13'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'

  s.vendored_libraries = "Libraries/**/*.dylib"
#   s.vendored_frameworks = 'QtCore.framework'
#   s.vendored_library    = 'libcouch_shared.dylib'
  #s.dependency 'sqlite3', '~> 3.40.0'
  #s.dependency 'sqlite3/fts5'
end
