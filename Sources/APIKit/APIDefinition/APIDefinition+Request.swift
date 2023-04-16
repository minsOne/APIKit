//
//  APIDefinition+Request.swift
//
//
//  Created by minsOne on 2023/04/13.
//

import _Concurrency
import Foundation

public extension APIDefinition {
    @discardableResult
    func request(completion: @escaping ((Result<Response, APIError>) -> Void)) -> URLSessionDataTask {
        return _request(completion: completion)
    }
}

public extension APIDefinition {
    func request() async -> Result<Response, APIError> {
        await withCheckedContinuation { continuation in
            request(completion: {
                continuation.resume(returning: $0)
            })
        }
    }
}

internal extension APIDefinition {
    func _request(service: URLSessionServicable = URLSessionService(),
                 completion: @escaping ((Result<Response, APIError>) -> Void)) -> URLSessionDataTask {
        let url = urlInfo.url
        let request = requestInfo.requests(url: url, method: method)

#if DEBUG
        print(request.cURL())
#endif

        return service.request(request: request,
                               completion: completion)
    }
}
