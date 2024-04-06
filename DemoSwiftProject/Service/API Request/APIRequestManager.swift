//
//  APIRequestManager.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation
import Combine

/// Protocol to adopt for better abstraction and testability.
protocol APIRequestManagerInterface: AnyObject {
    func performRequest<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, APIErrorHandler>
}

/// Project Network Manager implementing a generic method to be used for all URLSession requests.
final class APIRequestManager: APIRequestManagerInterface {
    private let urlSession: URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    func performRequest<T: Decodable>(_ request: URLRequest, decodingType: T.Type) -> AnyPublisher<T, APIErrorHandler> {
        return urlSession.dataTaskPublisher(for: request)
            .tryMap() { [weak self] element -> Data in
                guard let self = self else { throw APIErrorHandler.badRequest }
                try self.validateResponse(element.response)
                return element.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .mapError({ error -> APIErrorHandler in
                if let error = error as? APIErrorHandler {
                    return error
                }
                return APIErrorHandler.decodingError
            })
            .eraseToAnyPublisher()

    }
}

/// To handle HTTPURLResponse errors.
private extension APIRequestManager {
    func validateResponse(_ response: URLResponse) throws {
        guard let response = response as? HTTPURLResponse else {
            throw APIErrorHandler.badRequest
        }
        switch response.statusCode {
        case 200..<300:
            return
        case 400:
            throw APIErrorHandler.badRequest
        case 401:
            throw APIErrorHandler.unauthorized
        case 404:
            throw APIErrorHandler.notFound
        case 408:
            throw APIErrorHandler.requestTimeout
        case 429:
            throw APIErrorHandler.tooManyRequests
        case 500:
            throw APIErrorHandler.serverError
        default:
            throw APIErrorHandler.http(statusCode: response.statusCode)
        }
        
    }
}
