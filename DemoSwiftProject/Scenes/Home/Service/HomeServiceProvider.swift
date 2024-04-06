//
//  HomeServiceProvider.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation

enum CatServiceProvider {
    case getAFact
}

extension CatServiceProvider {
    func buildRequest() -> Result<URLRequest, APIErrorHandler> {
        switch self {
        case .getAFact:
            URLRequestBuilder(with: "https://meowfacts.herokuapp.com")
                .build()
        }
    }
}
