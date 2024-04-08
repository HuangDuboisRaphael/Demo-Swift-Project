//
//  ProfileResponse.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 08/04/2024.
//

import Foundation

struct ProfileResponse: Codable {
    let name: String?
    let company: String?
    let location: String?
    let followers: Int
}
