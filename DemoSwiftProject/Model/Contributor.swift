//
//  Contributor.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 08/04/2024.
//

import Foundation

struct Contributor {
    var id: Int
    var avatar: String
    var avatarData: Data
    var url: String
    var name: String?
    var company: String?
    var location: String?
    var followers: Int?
}

/// Structure convenience init.
extension Contributor {
    init(id: Int, avatar: String, url: String) {
        self.init(id: id, avatar: avatar, avatarData: Data(), url: url, name: "", company: "", location: "", followers: 0)
    }
}
