//
//  AppDelegate.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/26.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ウィンドウを作成
        window = UIWindow(frame: UIScreen.main.bounds)
        
        // NovelViewControllerのインスタンスを作成
        let novelViewController = NovelViewController()
        
        // NavigationControllerにNovelViewControllerをルートとして設定
        let navController = UINavigationController(rootViewController: novelViewController)
        
        // NavigationControllerをウィンドウのルートビューコントローラーとして設定
        window?.rootViewController = navController
        
        // ウィンドウを表示
        window?.makeKeyAndVisible()
        
        return true
    }
}


