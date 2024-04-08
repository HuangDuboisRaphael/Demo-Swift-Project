//
//  DetailServiceProvider.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 08/04/2024.
//

import Foundation

enum DetailServiceProvider {
    case getContributorProfile(url: String)
}

extension DetailServiceProvider {
    func buildRequest() -> Result<URLRequest, APIErrorHandler> {
        switch self {
        case .getContributorProfile(let url):
            URLRequestBuilder(with: url)
                .build()
        }
    }
}
