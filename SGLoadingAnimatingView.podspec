Pod::Spec.new do |s|
  s.name         = 'SGLoadingAnimatingView'
  s.summary      = 'A wonderful loading animation.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'sylphghost' => 'sylphghost@outlook.com' }
  s.homepage     = 'https://github.com/sylphghost/SGLoadingAnimatingView'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/sylphghost/SGLoadingAnimatingView.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'SGLoadingAnimatingView/**/*.{h,m}'

end
