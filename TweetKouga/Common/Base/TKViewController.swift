//
//  TKViewController.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/15.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit


/// Base View Controller
class TKViewController: UIViewController {
}

protocol UIPresentable {
    func showDialog(status: String)
    func showToast(status: String, timeInterval: TimeInterval)
}

extension UIPresentable where Self: UIViewController {
    func showDialog(status: String) {
        
    }
    func showToast(status: String, timeInterval: TimeInterval = 2) {
        
    }
}
