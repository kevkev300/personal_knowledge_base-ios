//
//  WKWebViewConfiguration+App.swift  .swift
//  personal_knowledge_base-ios
//
//  Created by Kevin Liebholz on 12.04.24.
//

import Foundation
import WebKit
import Strada

enum WebViewPool {
    static var shared = WKProcessPool()
}

extension WKWebViewConfiguration {
    static var appConfiguration: WKWebViewConfiguration {
        let stradaComponents = [FormComponent.self]
        let stradaSubstring = Strada.userAgentSubstring(for: stradaComponents)
        let userAgent = "Turbo Native iOS \(stradaSubstring)"
        
        let configuration = WKWebViewConfiguration()
        configuration.processPool = WebViewPool.shared
        configuration.applicationNameForUserAgent = userAgent
        configuration.defaultWebpagePreferences?.preferredContentMode = .mobile
        
        return configuration
    }
}
