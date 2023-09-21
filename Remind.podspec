Pod::Spec.new do |s|
  s.name         = "Remind"
  s.version      = "1.1.0"
  s.summary      = "Simple swift toast notifications"
  s.homepage     = "https://github.com/iLiuChang/Remind"
  s.license      = "MIT"
  s.authors      = { "iLiuChang" => "iliuchang@foxmail.com" }
  s.platform     = :ios, "10.0"
  s.source       = { :git => "https://github.com/iLiuChang/Remind.git", :tag => s.version }
  s.requires_arc = true
  s.swift_version = "5.0"
  s.source_files = "Source/*.{swift}"
end
