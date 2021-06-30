//
//  AppDelegate.swift
//  Hello CDP
//
//  Copyright © 2020 Salesforce. All rights reserved.
//

import UIKit
import Cdp
import SFMCSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        initializeCdpSDK()
        
        return true
    }
    
    private func initializeCdpSDK() {
        CdpSdk.setLogLevel(<#T##logLevel: MCLogLevel##MCLogLevel#>, logOutputter: <#T##LogOutputter#>)
        // Can use default LogOutputter() or custom subclass. See example: HelloCDPLogOutputter.swift
        
        // configure
        let config = CdpConfigBuilder(appId: <#T##String#>, endpoint: <#T##String#>)
            .trackScreens(<#T##enable: Bool##Bool#>)
            .trackLifecycle(<#T##enable: Bool##Bool#>)
            .sessionTimeout(<#T##seconds: Int##Int#>)
            .build()
        
        // initialize
        CdpSdk.configure(config)
    }

}
