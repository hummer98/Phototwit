# Pods for Yamori

platform :ios, '11.0'

use_frameworks!

inhibit_all_warnings!

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.2'
        end
    end
end

def install_pods
  pod 'ActionKit'
  pod 'AssistantKit'
  pod 'Crashlytics'
  pod 'Firebase'
  pod 'Firebase/Core'
  pod 'Firebase/Auth'
  pod 'Firebase/RemoteConfig'
  pod 'GoogleAnalytics'
  pod 'AlamofireSwiftyJSON'
  pod 'InstantiateStandard'
  pod 'KeychainAccess'
  pod 'Kingfisher'
  pod 'ObjectMapper'
  pod 'R.swift'
  pod 'RxSwift'
  pod 'ReachabilitySwift'
  pod 'SnapKit'
  pod 'SwiftDate'
  pod 'SVProgressHUD'
  pod 'TwitterKit', '<3.3.0'
  pod 'TwitterCore', '<3.1.0'
  pod 'Toast-Swift'
  pod 'UIColor_Hex_Swift'
  pod 'XCGLogger'
  pod 'SwiftyUserDefaults'
end

target 'TweetKouga' do
  install_pods

  target 'TweetKougaTests' do
    inherit! :search_paths
  end

  target 'TweetKougaUITests' do
    inherit! :search_paths
  end

end
