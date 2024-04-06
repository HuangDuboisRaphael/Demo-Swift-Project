//
//  URLRequestBuilder.swift
//  DemoSwiftProject
//
//  Created by Raphaël Huang-Dubois on 06/04/2024.
//

import Foundation

/// Builder class to create custom URLRequest and avoiding boilerplate code.
/// All project requests will be built using that class.
final class URLRequestBuilder {
    var baseURL: String
    var path: String?
    var method: HTTPMethod = .get
    var headers: [String: Any]?
    var queryItems: [URLQueryItem]?
    var parameters: [String: Any]?
    
    init(with baseURL: String) {
        self.baseURL = baseURL
    }
    
    func set(method: HTTPMethod) -> Self {
        self.method = method
        return self
    }
    
    func set(path: String?) -> Self {
        self.path = path
        return self
    }
    
    func set(headers: [String: Any]?) -> Self {
        self.headers = headers
        return self
    }
    
    func set(queryItems: [URLQueryItem]?) -> Self {
        self.queryItems = queryItems
        return self
    }
    
    func set(parameters: [String: Any]?) -> Self {
        self.parameters = parameters
        return self
    }
    
    /// Use of Result for errors propagation and compatibility with publishers.
    func build() -> Result<URLRequest, APIErrorHandler> {
        /// Check url and add query items if needed.
        var url: URL
        if let queryItems = queryItems {
            var urlComponents = URLComponents(string: baseURL)
            urlComponents?.queryItems = queryItems
            guard let urlWithQuery = urlComponents?.url else {
                return .failure(APIErrorHandler.badUrl)
            }
            url = urlWithQuery
        } else {
            guard let defaultUrl = URL(string: baseURL) else {
                return .failure(APIErrorHandler.badUrl)
            }
            url = defaultUrl
        }
        
        /// Initiate URLRequest with specific path if needed.
        var request = path != nil ? URLRequest(url: url.appendingPathComponent(path!)) : URLRequest(url: url)
        
        /// Instantiate httpMethod.
        request.httpMethod = method.rawValue
        
        /// Add headers to request.
        headers?.forEach {
            if let value = $0.value as? String {
                request.addValue(value, forHTTPHeaderField: $0.key)
            }
        }
        
        /// Add parameters to request.
        if let parameters = parameters {
            do {
                request = try encode(request, with: parameters)
            } catch {
                return .failure(APIErrorHandler.encodingError)
            }
        }
        return .success(request)
    }
}

/// To encode paramaters.
extension URLRequestBuilder {
    private func encode(_ request: URLRequest, with parameters: [String: Any]) throws -> URLRequest {
        var request = request
        let jsonAsData = try serializedParameters(parameters)
        request.httpBody = jsonAsData
        if request.value(forHTTPHeaderField: "Content-Type") == nil {
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        }
        return request
    }
    
    func serializedParameters(_ parameters: [String: Any]) throws -> Data {
        do {
            return try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            throw APIErrorHandler.encodingError
        }
    }
}
