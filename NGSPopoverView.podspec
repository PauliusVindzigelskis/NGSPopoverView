#
# Be sure to run `pod lib lint NGSPopoverView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "NGSPopoverView"
  s.version          = "0.1.0"
  s.summary          = "Universal simple popover view to show any kind of content which is subclass of UIView."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = "Universal simple popover view to show any kind of content which is subclass of UIView. Works in both - iPhone and iPad. Easy customizable."

  s.homepage         = "https://bitbucket.org/pvindzigelskis/ngspopoverview"
  s.screenshots     = "https://bitbucket.org/repo/8yGqo8/images/2516946630-rounded_corner.png", "https://bitbucket.org/repo/8yGqo8/images/3076218040-fill_screen.png", "https://bitbucket.org/repo/8yGqo8/images/3619268285-mask_view.png"
  s.license          = 'MIT'
  s.author           = { "Paulius Vindzigelskis" => "p.vindzigelskis@gmail.com" }
  s.source           = { :git => "https://pvindzigelskis@bitbucket.org/pvindzigelskis/ngspopoverview.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'NGSPopoverView' => ['Pod/Assets/*.png']
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
