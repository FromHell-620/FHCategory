
Pod::Spec.new do |s|
  s.name         = "FHCategory"
  s.version      = "0.0.10"
  s.summary      = "category."
  s.homepage     = "https://github.com/FromHell-620/FHCategory"
  s.license      = "MIT"
  s.author       = { "GodL" => "547188371@qq.com" }
  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/FromHell-620/FHCategory.git", :tag => s.version.to_s }
  s.source_files  = "FHCategory/*.{h,m}"
  s.framework  = "UIKit"
  s.requires_arc = true
end
