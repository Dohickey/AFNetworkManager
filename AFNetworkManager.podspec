Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "AFNetworkManager"
s.summary = "AFNetworkManager helps to make API calls with AFNetworking."

# 2
s.version = "0.0.1"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4
s.author = { "Nilson Filho" => "nilson@mane.app" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/TheCodedSelf/RWPickFlavor"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/Dohickey/AFNetworkManager.git",
:tag => "#{s.version}" }

# 7
s.framework = "UIKit"
s.dependency 'AFNetworking', '~> 3.0'

# 9
s.resources = "AFNetworkManager/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

end
