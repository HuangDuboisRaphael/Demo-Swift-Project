//
//  Result+Extensions.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 07/04/2024.
//

import Foundation
import Combine

extension Result<URLRequest, APIErrorHandler> {
    func performRequest<T: Decodable>(_ networkManager: APIRequestManagerInterface, decodingType: T.Type) -> AnyPublisher<T, APIErrorHandler> {
        switch self {
        case .success(let request):
            return networkManager.performRequest(request, decodingType: T.self)
        case .failure(let error):
            let publisher = PassthroughSubject<T, APIErrorHandler>()
            publisher.send(completion: .failure(error))
            return publisher.eraseToAnyPublisher()
        }
    }
}
