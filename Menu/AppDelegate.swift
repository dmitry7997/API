//
//  AppDelegate.swift
//  DoorDashTPS-Menu
//
//  Created by Jeff Cosgriff on 10/3/19.
//  Copyright © 2019 DoorDash, Inc. All rights reserved.
//

//#if UIKIT

//import UIKit
//
//@UIApplicationMain
//class AppDelegate: UIResponder, UIApplicationDelegate {
//    var window: UIWindow?
//    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        return true
//    }
//}

//#else

import SwiftUI

@main
struct Menu: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var addDelegate
    var body: some Scene {
        WindowGroup {
            MainView(service: ContentServiceCombine())
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
}
//#endif
