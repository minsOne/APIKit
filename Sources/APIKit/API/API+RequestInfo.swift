//
//  File.swift
//
//
//  Created by minsOne on 2023/04/13.
//

import Foundation

public extension API {
    struct RequestInfo<T: Parameterable> {
        var headers: [String: String]?
        var parameters: T?

        public init(headers: [String: String]? = nil,
                    parameters: T? = nil)
        {
            self.headers = headers
            self.parameters = parameters
        }
    }
}

extension API.RequestInfo {
    func requests(url: URL, method: URLMethod) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = parameters?
            .dictionary
            .flatMap { try? JSONSerialization.data(withJSONObject: $0) }

        headers.map {
            request.allHTTPHeaderFields?.merge($0) { lhs, _ in lhs }
        }
        return request
    }
}
