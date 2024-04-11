//
//  SceneDelegate.swift
//  personal_knowledge_base-ios
//
//  Created by Kevin Liebholz on 09.04.24.
//

import UIKit
import Turbo

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    // A session in Turbo native is the object that visits screens, pops them onto the hierachy, adapter that hooks into the JS for Turbo.js,
    private let session = Session()
    private let navigationController = UINavigationController()
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        visit()
    }
    
    private func visit() {
        let url = URL(string: "http://localhost:3000")!
        // a VisitableViewController doesn't do anything on its own, it just manages the web view. So, we still need to actually visit the URL. We do that with a session
        let controller = VisitableViewController(url: url)
        session.visit(controller, action: .advance)
        navigationController.pushViewController(controller, animated: true)
    }
}
