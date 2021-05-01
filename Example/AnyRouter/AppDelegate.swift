//
//  AppDelegate.swift
//  AnyRouter
//
//  Created by hushaohua8503 on 03/08/2021.
//  Copyright (c) 2021 hushaohua8503. All rights reserved.
//

import UIKit
import AnyRouter
import ModuleDemo

struct ObjectRouterHandler : RouterHandlerProtocol{
    func handleRouter(url: String, parameters: [String : Any]?, completion: ((RouterResponseProtocol) -> Void)?) {
        completion?(RouterResponse(data: "ObjectRouterHandler-success"))
    }
}

struct ClassRouterHandler : RouterStaticHandlerProtocol {
    static func handleRouter(url: String, parameters: [String : Any]?, completion: ((RouterResponseProtocol) -> Void)?) {
        completion?(RouterResponse(data: "ClassRouterHandler-success"))
    }
}

class ClassRouterHandler2 : RouterStaticHandlerProtocol {
    static func handleRouter(url: String, parameters: [String : Any]?, completion: ((RouterResponseProtocol) -> Void)?) {
        completion?(RouterResponse(data: "ClassRouterHandler2-success"))
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var handler = ObjectRouterHandler()
    var other = OtherModuleManager();
    
    func registerRouter() {
        RouterCenter.default.register(url: "https://m.baidu.com", handlerClass: ClassRouterHandler.self)
        RouterCenter.default.register(url: "https://m.init.com", handlerObject: handler)
        RouterCenter.default.register(url: "https://testvc", viewController: TestRouterViewController.self)
        RouterCenter.default.register(url: "https://testvc/:id", viewController: TestRouterViewController1.self)
        
        //以下为配置文件中读取
        if let url = Bundle.main.url(forResource: "Router", withExtension: "plist") {
            RouterHandlerLoader.loadFile(url, from: Bundle.main)
        }
        
        other.start()
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        registerRouter();
        
        AnyRouter.request(url: "https://m.baidu.com") { (response) in
            print("\(response?.data ?? "m.baidu.com")")
        }
        AnyRouter.request(url: "https://m.init.com") { (response) in
            print("\(response?.data ?? "m.init.com")")
        }
        //https://testhandler/test
        AnyRouter.request(url: "https://testhandler/test") { (response) in
            print("\(response?.data ?? "testhandler/test")")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

