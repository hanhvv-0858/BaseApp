//
//  AppDelegate.swift
//  BaseApp
//
//  Created by Phong Nguyen on 9/10/17.
//  Copyright © 2017 Phong Nguyen. All rights reserved.
//

import UIKit
import Alamofire
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    let manager = NetworkReachabilityManager(host: "www.apple.com")
    
    // MARK: - AppLifeCycle
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        configApp()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        application.applicationIconBadgeNumber += 1

    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }
    
    // MARK: - Handling Remote Notification Registration
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Tells the delegate that the app successfully registered with Apple Push Notification service (APNs).
    }
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Sent to the delegate when Apple Push Notification service cannot successfully complete the registration process.
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Tells the app that a remote notification arrived that indicates there is data to be fetched.
    }
    
    // MARK: - Downloading Data in the Background
    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Tells the app that it can begin a fetch operation if it has data to download.
    }
    func application(_ application: UIApplication, handleEventsForBackgroundURLSession identifier: String, completionHandler: @escaping () -> Void) {
        // Tells the delegate that events related to a URL session are waiting to be processed
    }
}




extension AppDelegate {
    fileprivate func configApp() {
        FirebaseApp.configure()
        RealmManager.config()
        RootViewConfig.sharedInstance.config(window: self.window)
        ReadNetworking.sharedInstance.start(manager: manager)
    }
}
