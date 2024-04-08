//
//  Configuration.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 07/04/2024.
//

import Foundation

enum Environment: String {
    case dev
    case staging
    case production
}

enum Configuration {
    enum API {
        static var baseUrl: String {
            "https://api.github.com/repos/apple/swift/contributors"
        }
    }
}
