//
//  AppDelegate.swift
//  JiShanBuddhistFriends
//
//  Created by Simon on 2018/10/23.
//  Copyright © 2018 Simon. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let rootVC = BFTabBarViewController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootVC
        window?.makeKeyAndVisible()

        //开启推送通知
//        let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound],
//                                                  categories: nil)
//        application.registerUserNotificationSettings(settings)
//
        
        //-- 注册推送
        let center = UNUserNotificationCenter.current()
        center.delegate = self as UNUserNotificationCenterDelegate
        center.getNotificationSettings { (setting) in
            if setting.authorizationStatus == .notDetermined {
                // 未注册
                center.requestAuthorization(options: [.badge,.sound,.alert]) { (result, error) in
                    print("显示内容：\(result) error：\(String(describing: error))")
                    if(result){
                        if !(error != nil){
                            print("注册成功了！")
                            application.registerForRemoteNotifications()
                        }
                    } else{
                        print("用户不允许推送")
                    }
                }
            } else if (setting.authorizationStatus == .denied){
                //用户已经拒绝推送通知
                //-- 弹出页面提示用户去显示
                
            }else if (setting.authorizationStatus == .authorized){
                //已注册 已授权 --注册同志获取 token
                // 请求授权时异步进行的，这里需要在主线程进行通知的注册
                DispatchQueue.main.async {
                    UIApplication.shared.registerForRemoteNotifications()
                }
                
            }else{
                
            }
        }


        
        return true
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
        //进入前台模式 刷新一下当天日期显示
        BFMessager.Instance.dispatch(MessageID.applicationWillEnterForeground, data: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

