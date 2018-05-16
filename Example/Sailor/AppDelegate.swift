//
//  AppDelegate.swift
//  Sailor
//
//  Created by oscarvgg on 02/03/2018.
//  Copyright (c) 2018 oscarvgg. All rights reserved.
//

import UIKit
import Sailor

var navigator: NavigatorController = NavigatorController.instantiateViewController(
    route: Routes.rootController) as! NavigatorController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        navigator.pathProvider = Routes.self
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigator
        window?.makeKeyAndVisible()
        
        do {
            try navigator.navigate(to: Routes.signin, completion: nil)
        } catch let error {
            print(error)
        }
        
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
