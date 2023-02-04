#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint quantum.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'quantum_sqlite'
  s.version          = '0.0.1'
  s.summary          = 'A new flutter plugin project.'
  s.description      = <<-DESC
A new flutter plugin project.
                       DESC
  s.homepage         = 'https://multiverse.direct'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.platform = :ios, '14.0'

  s.swift_version = '5.0'

  s.pod_target_xcconfig = { 
    'DEFINES_MODULE' => 'YES',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386',
    'LD_RUNPATH_SEARCH_PATHS' => '@loader_path/../Frameworks',
    'OTHER_LDFLAGS' => '$(inherited) -ObjC'
   }
  s.vendored_libraries = 'Libraries/libsimple.a', 'Libraries/libPINYIN_TEXT.a'

  s.dependency 'sqlite3', '~> 3.40.0'
  s.dependency 'sqlite3/fts5'
end
