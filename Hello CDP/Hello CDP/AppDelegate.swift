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
        // Debug level not recommended for production apps as significant data will be logged to the console.
#if DEBUG
        SFMCSdk.setLogger(logLevel: LogLevel.debug, logOutputter: HelloCDPLogOutputter.shared)
#endif
        // Can use default LogOutputter() or custom subclass. See example: HelloCDPLogOutputter.swift
        
        // Example Mobile Connector schema used in this demo:
        // https://cdn.c360a.salesforce.com/cdp/schemas/238/mobile-connector-schema.json
        
        SFMCSdk.initializeSdk(
            ConfigBuilder()
                //.setPush(config: mobilePushConfiguration) // If using PUSH make sure to only call initializeSdk once.
                .setCdp(config: getCDPConfig())
            .build()
        ) {
            status in
                for moduleStatus in status where moduleStatus.moduleName == ModuleName.cdp {
                    if moduleStatus.initStatus == .success {
                        SFMCSdkLogger.shared.logMessage(level: .debug,
                                                        subsystem: LoggerSubsystem.module(value: ModuleName.cdp),
                                                        category: LoggerCategory.session,
                                                        message: "CDP init onComplete: " + CdpModule.shared.state)
                    }
                }
        }
        
        // Keep in mind events are only sent across the network once one of the following conditions are met:
        // 1. The app is backgrounded or foregrounded.
        // 2. A threshold of 20 events have been queued.
    }

    // Data Cloud Setup -> Websites & Mobile Apps -> Your Mobile App Connector -> Integration Guide
    // https://help.salesforce.com/s/articleView?id=sf.c360_a_web_mobile_app_connector.htm&type=5
    func getCDPConfig() -> ModuleConfig {
        // TODO: Replace Data Cloud (CDP) Mobile App connector properties
        return CdpConfigBuilder(
            //appId: "", // <-- ** UPDATE your Source ID **
            //endpoint: "https://" // <-- ** UPDATE your Tenant Specific Endpoint **
        )
        .trackScreens(true) // default: false
        .trackLifecycle(true) // default: false
        .sessionTimeout(600) // default: 600
        .build()
    }

}
