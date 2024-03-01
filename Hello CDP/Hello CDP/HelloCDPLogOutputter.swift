//
//  HelloCDPLogOutputter.swift
//  Hello CDP
//
//  Copyright © 2020 Salesforce. All rights reserved.
//

import Foundation
import SFMCSDK

// Custom Logger
class HelloCDPLogOutputter: LogOutputter {
    var logMessages: [String] = []

    static let shared = HelloCDPLogOutputter()
    
    override func out(level: LogLevel, subsystem: String, category: LoggerCategory, message: String) {
        logMessages.append(message)
        print(subsystem, category.rawValue, message)
    }
}
