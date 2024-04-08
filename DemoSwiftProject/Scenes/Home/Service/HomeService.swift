//
//  HomeService.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation
import Combine

protocol HomeServiceInterface: AnyObject {
    func getContributor() -> AnyPublisher<[ContributorResponse], APIErrorHandler>
    func getAvatarImage(from url: String) -> AnyPublisher<Data, APIErrorHandler>
}

final class HomeService: HomeServiceInterface {
    private let networkManager: APIRequestManagerInterface
    
    init(networkManager: APIRequestManagerInterface = APIRequestManager()) {
        self.networkManager = networkManager
    }
    
    func getContributor() -> AnyPublisher<[ContributorResponse], APIErrorHandler> {
        let result = HomeServiceProvider.getContributor.buildRequest()
        return result.performRequest(networkManager, decodingType: [ContributorResponse].self)
    }
    
    func getAvatarImage(from url: String) -> AnyPublisher<Data, APIErrorHandler> {
        let result = HomeServiceProvider.getAvatarImage(url: url).buildRequest()
        return result.performImageRequest(networkManager)
    }
}
