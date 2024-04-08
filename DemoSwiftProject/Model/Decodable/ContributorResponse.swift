//
//  ContributorResponse.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation

struct ContributorResponse: Codable {
    let id: Int
    let avatar: String
    let url: String
}

extension ContributorResponse {
    enum CodingKeys: String, CodingKey {
        case id
        case avatar = "avatar_url"
        case url
    }
}
