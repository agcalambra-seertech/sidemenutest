platform :ios, '8.0'
use_frameworks!

source 'https://github.com/CocoaPods/Specs.git'

target 'SideMenuTest’ do
    pod 'ENSwiftSideMenu', '~> 0.1.1'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end