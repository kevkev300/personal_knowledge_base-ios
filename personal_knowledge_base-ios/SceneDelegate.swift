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
    
    private let navigationController = UINavigationController()
    
    // A session in Turbo native is the object that visits screens, pops them onto the hierachy, adapter that hooks into the JS for Turbo.js,
    private lazy var session: Session = {
        let session = Session()
        session.delegate = self // `self` == SceneDelegate
        return session
    }()
    
    // App launches
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        visit()
    }
    
    // a VisitableViewController doesn't do anything on its own, it just manages the web view. So, we still need to actually visit the URL. We do that with a session
    // App launches
    private func visit() {
        let url = URL(string: "http://localhost:3000")!
        let controller = VisitableViewController(url: url)
        session.visit(controller, action: .advance)
        
        // push contoller (aka screen) onto the stack
        navigationController.pushViewController(controller, animated: true)
    }
}

// without the Delegate, the framework cannot let us know when a new screen/link is pushed

// Tell SceneDelegate that it conforms to the SessionDelegate protocol
extension SceneDelegate: SessionDelegate {
    func session(_ session: Session, didProposeVisit proposal: VisitProposal) {
        let controller = VisitableViewController(url: proposal.url)
        session.visit(controller, options: proposal.options) // options: type of action (advance, replace...), maintain cache, ...
        navigationController.pushViewController(controller, animated: true)
    }
    
    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, error: Error) {
        // TODO: handle errors e.g. 400.
    }
    
    func sessionWebViewProcessDidTerminate(_ session: Session) {
        // TODO: handle dead web view.
    }
    
    
}
