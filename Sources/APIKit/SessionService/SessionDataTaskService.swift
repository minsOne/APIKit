//
//  SessionDataTaskService.swift
//  
//
//  Created by minsOne on 2023/04/16.
//

import Foundation

protocol SessionDataTaskServicable {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, Int?, Error?) -> Void) -> URLSessionDataTask
}

struct SessionDataTaskService: SessionDataTaskServicable {
    func dataTask(with request: URLRequest, completionHandler: @escaping @Sendable (Data?, Int?, Error?) -> Void) -> URLSessionDataTask {
        let session = URLSession.shared

        return session.dataTask(with: request, completionHandler: { data, response, error in
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            completionHandler(data, statusCode, error)
        })
    }
}
