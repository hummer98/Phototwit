//
//  AccountListViewController.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import Instantiate
import InstantiateStandard
import TwitterKit

final class AccountListViewController: TKViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if let session = session {
                print("signed in as \(session.userName)");
            } else {
                print("error: \(error?.localizedDescription)");
            }
        })
        logInButton.center = self.view.center
        self.view.addSubview(logInButton)
    }
    @IBAction private func login() {
        Twitter.sharedInstance().logIn { (session, error) in
            
        }
    }
}

extension AccountListViewController: StoryboardInstantiatable {}

