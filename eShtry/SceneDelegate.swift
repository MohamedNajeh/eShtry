//
//  SceneDelegate.swift
//  eShtry
//
//  Created by Najeh on 10/03/2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        window?.rootViewController = createTabBarController()
        window?.makeKeyAndVisible()
    }
    
    
    private func createHomeNC()->UINavigationController{
        let homeNC = CartVC()
        homeNC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "homeIcon"), tag: 1)
        
        return UINavigationController(rootViewController: homeNC)
    }
    
    private func createCategoriesNC()-> UINavigationController{
        let cateegoriesNC = CartVC()
        let imageIcon = UIImage(systemName: "text.alignleft")
        cateegoriesNC.tabBarItem = UITabBarItem(title: "Categories", image: imageIcon, tag: 2)
        return UINavigationController(rootViewController: cateegoriesNC)
    }
    
    private func createCartNC()-> UINavigationController{
        let cartNC = CartVC()
        let imageIcon = UIImage(systemName: "cart")
        cartNC.tabBarItem = UITabBarItem(title: "Cart", image: imageIcon, tag: 3)
        return UINavigationController(rootViewController: cartNC)
    }
    
    private func createMoreNC()-> UINavigationController{
        let storyboard = UIStoryboard(name: "meVC", bundle: .main)
        let moreNC     = storyboard.instantiateViewController(withIdentifier: "me")
        let imageIcon = UIImage(systemName: "list.bullet")
        moreNC.tabBarItem = UITabBarItem(title: "More", image: imageIcon, tag: 4)

        return UINavigationController(rootViewController: moreNC)
    }

    
    func createTabBarController() -> UITabBarController{
        let tabBar = UITabBarController()
        UITabBar.appearance().tintColor = UIColor.init(red: 0/255, green: 59/255, blue: 118/255, alpha: 1)
        tabBar.viewControllers = [createHomeNC(),createCategoriesNC(),createCartNC(),createMoreNC()]
//        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = .white
        
        return tabBar
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

