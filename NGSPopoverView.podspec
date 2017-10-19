#
# Be sure to run `pod lib lint NGSPopoverView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NGSPopoverView"
  s.version          = "1.2.0"
  s.summary          = "Universal simple popover view to show any kind of content which is subclass of UIView."
  s.homepage         = "https://github.com/PauliusVindzigelskis/NGSPopoverView"
 
  s.description      = "Universal simple popover view to show any kind of content which is subclass of UIView. Works in both - iPhone and iPad. Easy customizable."

#s.screenshots      = "https://bitbucket.org/repo/8yGqo8/images/2516946630-rounded_corner.png", "https://bitbucket.org/repo/8yGqo8/images/3076218040-fill_screen.png", "https://bitbucket.org/repo/8yGqo8/images/3619268285-mask_view.png"
  s.license          = 'MIT'
  s.author           = { "Paulius Vindzigelskis" => "p.vindzigelskis@gmail.com" }
  s.source           = { :git => "https://github.com/PauliusVindzigelskis/NGSPopoverView.git", :tag => "R#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
