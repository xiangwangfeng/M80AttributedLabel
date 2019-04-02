//
//  AppDelegate.swift
//  SwiftDemo
//
//  Created by amao on 2016/10/12.
//  Copyright © 2016年 amao. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
       
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let vc = DemoTableViewController()
        let nav = UINavigationController(rootViewController: vc)
        self.window?.rootViewController = nav
        self.window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {

    }


}

