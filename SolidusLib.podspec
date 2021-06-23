Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "SolidusLib"
s.summary = "SolidusLib is an integration for iOS with the Solidus E-Commerce system."
s.requires_arc = true
s.version = "0.1.5"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Magma Labs" => "hello@magmalabs.io" }
s.homepage = "https://www.magmalabs.io/"
s.source = { :git => "https://github.com/magma-labs/Solidus_lib_iOS.git", :tag => "#{s.version}"}
s.source_files = "SolidusLib/**/*.{swift}"
s.framework = "Foundation"
s.dependency 'Alamofire', '~> 4.0.0'
s.dependency 'AlamofireObjectMapper', '~>4.0.0'
s.dependency 'AlamofireImage', '~> 3.1'

end
