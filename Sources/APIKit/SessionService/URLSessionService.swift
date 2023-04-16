//
//  URLSessionService.swift
//
//
//  Created by minsOne on 2023/04/16.
//

import Foundation

protocol URLSessionServicable {
    func request<T: Decodable>(request: URLRequest,
                               completion: @escaping ((Result<T, APIError>) -> Void)) -> URLSessionDataTask
}

struct URLSessionService: URLSessionServicable {
    let service: SessionDataTaskServicable

    init(_ service: SessionDataTaskServicable = SessionDataTaskService()) {
        self.service = service
    }

    func request<T: Decodable>(request: URLRequest,
                               completion: @escaping ((Result<T, APIError>) -> Void)) -> URLSessionDataTask
    {
        let dataTask = service.dataTask(with: request) { data, statusCode, error in
            if let error {
                completion(.failure(.error(error)))
                return
            }

            if let error = statusCode.flatMap(APIError.statusCodeError(statusCode:)) {
                completion(.failure(error))
                return
            }

            guard let data else {
                completion(.failure(.emptyResponse))
                return
            }

            do {
                let response = try JSONDecoder().decode(T.self, from: data)
                completion(.success(response))
            } catch {
                completion(.failure(.error(error)))
            }
        }

        return dataTask
    }
}
