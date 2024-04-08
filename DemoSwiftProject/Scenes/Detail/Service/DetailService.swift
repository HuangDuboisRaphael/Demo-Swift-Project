//
//  DetailService.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 08/04/2024.
//

import Foundation
import Combine

protocol DetailServiceInterface: AnyObject {
    func getContributorProfile(from url: String) -> AnyPublisher<ProfileResponse, APIErrorHandler>
}

final class DetailService: DetailServiceInterface {
    private let networkManager: APIRequestManagerInterface
    
    init(networkManager: APIRequestManagerInterface = APIRequestManager()) {
        self.networkManager = networkManager
    }
    
    func getContributorProfile(from url: String) -> AnyPublisher<ProfileResponse, APIErrorHandler> {
        let result = DetailServiceProvider.getContributorProfile(url: url).buildRequest()
        return result.performRequest(networkManager, decodingType: ProfileResponse.self)
    }
}
