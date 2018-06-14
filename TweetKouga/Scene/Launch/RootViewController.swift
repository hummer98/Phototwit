//
//  RootViewController.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import SnapKit

extension UIViewController {
    func addChildViewController(_ viewController: UIViewController, targetView: UIView) {
        targetView.addSubview(viewController.view)
        viewController.view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        addChildViewController(viewController)
        viewController.didMove(toParentViewController: self)
    }
}

final class RootViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // ローンチコントロール
        addChildViewController(launchScreenType().screen, targetView: view)
    }

    private func launchScreenType() -> LaunchScreen {
        if TwitterManager.isLoggedIn {
            return .tweetList
        } else {
            return .account
        }
    }

    func transitionTo(screen: LaunchScreen) {
        view.subviews.forEach { $0.removeFromSuperview() }
        addChildViewController(screen.screen)
    }
}
