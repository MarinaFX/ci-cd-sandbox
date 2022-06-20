//
//  AppDelegate.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 31/05/22.
//

import Foundation
import UIKit

import AppCenter
import AppCenterAnalytics
import AppCenterCrashes
import AppCenterDistribute
import SwiftUI

@main
class AppDelegate: NSObject, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        //Setting delegate the old way
        let window = UIWindow()
        self.window = window
        window.rootViewController = UIHostingController(rootView: ContentView())
        window.makeKeyAndVisible()
        
        guard let appCenterKey = Bundle.main.object(forInfoDictionaryKey: "APP_CENTER_KEY") as? String else {
            return false
        }
        
        print("Api Key: \(appCenterKey)")
        
//        AppCenter.start(withAppSecret: appCenterKey, services: [Analytics.self, Crashes.self, Distribute.self])
        
        
        return true
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        print(#function)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        print(#function)
    }
}
