//
//  HomeService.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation
import Combine

protocol CatServiceInterface: AnyObject {
    func getAFact() -> AnyPublisher<Cat, APIErrorHandler>
}

final class CatService: CatServiceInterface {
    private let networkManager: APIRequestManagerInterface
    
    init(networkManager: APIRequestManagerInterface = APIRequestManager()) {
        self.networkManager = networkManager
    }
    
    func getAFact() -> AnyPublisher<Cat, APIErrorHandler> {
        let result = CatServiceProvider.getAFact.buildRequest()
        return result.performRequest(networkManager, decodingType: Cat.self)
    }
}
