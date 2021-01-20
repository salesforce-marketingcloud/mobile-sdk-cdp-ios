//
//  HelloCDPLogOutputter.swift
//  Hello CDP
//
//  Copyright © 2020 Salesforce. All rights reserved.
//

import Foundation
import Core

// Custom Logger
class HelloCDPLogOutputter: LogOutputter {
    var logMessages: [String] = []

    static let shared = HelloCDPLogOutputter()
    
    override func out(level: MCLogLevel, subsystem: String, category: String, message: String) {
        logMessages.append(message)
        print(message)
    }
}
