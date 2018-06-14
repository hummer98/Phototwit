//
//  AppDelegate.swift
//  TweetKouga
//
//  Created by Yuji Yamamoto on 2018/06/14.
//  Copyright © 2018年 ridgeroot. All rights reserved.
//

import UIKit
import TwitterKit
import XCGLogger

let log: XCGLogger = {
    let log = XCGLogger.default
    /// APIログを見るには.verboseを指定
    log.setup(level: .debug, showThreadName: true, showLevel: true, showFileNames: true, showLineNumbers: true, fileLevel: .debug)
    return log
}()

@UIApplicationMain
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        getEnvironmentVariable()
        
        let env = ProcessInfo.processInfo.environment
        Twitter.sharedInstance().start(withConsumerKey: env["TWITTER_CONSUMER_KEY"]!, consumerSecret: env["TWITTER_CONSUMER_SECRET"]!)
        
        return true
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        if Twitter.sharedInstance().application(app, open: url, options: options) {
            return true
        }
        return false
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    static var rootViewController: RootViewController {
        return UIApplication.shared.keyWindow?.rootViewController as! RootViewController
    }
    
    static func transitionTo(screen: LaunchScreen) {
        rootViewController.transitionTo(screen: screen)
    }
    
    private func getEnvironmentVariable() {
        guard let path = Bundle.main.path(forResource: ".env", ofType: nil) else {
            fatalError("Not found: '.env'.\nPlease create .env file reference from .env.sample")
        }
        let url = URL(fileURLWithPath: path)
        do {
            let data = try Data(contentsOf: url)
            let str = String(data: data, encoding: .utf8) ?? "Empty File"
            let clean = str.replacingOccurrences(of: "\"", with: "").replacingOccurrences(of: "'", with: "")
            let envVars = clean.components(separatedBy:"\n")
            for envVar in envVars {
                let keyVal = envVar.components(separatedBy:"=")
                if keyVal.count == 2 {
                    setenv(keyVal[0], keyVal[1], 1)
                }
            }
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}

enum LaunchScreen {
    case tweetList
    case account
    var screen: UIViewController {
        switch self {
        case .tweetList:
            return TweetListViewController(with: ())
        case .account:
            return AccountListViewController(with: ())
        }
    }
}
