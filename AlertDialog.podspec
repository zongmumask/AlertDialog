Pod::Spec.new do |s|
  s.name             = 'AlertDialog'
  s.version          = '1.0.0'
  s.summary          = 'AlertDialog'

  s.description      = 'swift alert dialog lib'

  s.homepage         = 'https://gitlab.etest.tf.cn:21505/S000474/alertdialog.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'daniel hu' => 'zongmumask@gmail.com' }
  s.source           = { :git => 'https://gitlab.etest.tf.cn:21505/S000474/alertdialog.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  
  s.source_files = 'AlertDialog/Classes/**/*'
  
  s.swift_version = '5.0'

end
