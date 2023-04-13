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
        let url = urlInfo.url
        let request = requestInfo.requests(url: url, method: method)
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)

#if DEBUG
        print(request.cURL())
#endif

        let dataTask = session.dataTask(with: request) { data, _, error in
            if let error {
                completion(.failure(.error(error)))
                return
            }

            guard let data else {
                completion(.failure(.emptyResponse))
                return
            }

            do {
                let response = try JSONDecoder().decode(Response.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.error(error)))
            }
        }

        dataTask.resume()

        return dataTask
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
