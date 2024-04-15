//
//  FormComponent.swift
//  personal_knowledge_base-ios
//
//  Created by Kevin Liebholz on 12.04.24.
//

import Foundation
import Strada
import UIKit

final class FormComponent: BridgeComponent {
    // name of the component as in the Stimulus controller
    override class var name: String { "form" }
    private weak var button: UIBarButtonItem?
    
    // who is in charge of rendering this screen right now and is this a ViewController
    private var viewController: UIViewController? {
        delegate.destination as? UIViewController
    }
    
    // on every message we receive from the Stimulus controller we do...
    override func onReceive(message: Message) {
        guard let viewController = viewController else { return }
        guard let data: MessageData = message.data() else { return }

        // click on the element that this component was wired up to for the `connect` event
        let action = UIAction(title: data.submitTitle) { [unowned self] _ in
            self.reply(to: "connect")
        }
        
        // define native element
        let button = UIBarButtonItem(primaryAction: action)
        
        // use native button
        viewController.navigationItem.rightBarButtonItem = button
        self.button = button
    }
}

// data that matches to what we send as data within the stimulus controller `this.send`
private extension FormComponent {
    struct MessageData: Decodable {
        let submitTitle: String
    }
}
