Pod::Spec.new do |s|
  s.name         = "GlitchLabel"
  s.version      = "1.0.2"
  s.summary      = "Gliching UILabel for iOS"
  s.homepage     = "https://github.com/kciter/GlitchLabel"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "kciter" => "kciter@naver.com" }
  s.source       = { :git => "https://github.com/kciter/GlitchLabel.git", :tag => "#{s.version}" }
  s.platform     = :ios, '8.0'
  s.source_files = 'Sources/*.{swift}'
  s.frameworks   = 'UIKit', 'Foundation'
  s.requires_arc = true
end
