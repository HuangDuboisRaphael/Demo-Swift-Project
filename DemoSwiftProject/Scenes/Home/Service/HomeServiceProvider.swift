//
//  HomeServiceProvider.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation

enum HomeServiceProvider {
    case getContributor
    case getAvatarImage(url: String)
}

extension HomeServiceProvider {
    func buildRequest() -> Result<URLRequest, APIErrorHandler> {
        switch self {
        case .getContributor:
            URLRequestBuilder(with: Configuration.API.baseUrl)
                .build()
        case .getAvatarImage(let url):
            URLRequestBuilder(with: url)
                .build()
        }
    }
}
