//
//  SceneDelegate.swift
//  Tanpen
//
//  Created by まつはる on 2024/05/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        // ウィンドウを作成
        window = UIWindow(windowScene: windowScene)
        
        // NovelViewControllerのインスタンスを作成
        let novelViewController = NovelViewController()
        
        // NavigationControllerにNovelViewControllerをルートとして設定
        let navController = UINavigationController(rootViewController: novelViewController)
        
        // NavigationControllerをウィンドウのルートビューコントローラーとして設定
        window?.rootViewController = navController
        
        // ウィンドウを表示
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}


