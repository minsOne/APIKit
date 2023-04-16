//
//  StubAPI.swift
//
//
//  Created by minsOne on 2023/04/16.
//

import Foundation

@testable import APIKit

extension API.URLInfo {
    private static func stubAPI(path: String) -> Self {
        Self(host: "httpbin.org", path: path)
    }
}

enum StubAPI {}

extension StubAPI {
    struct Get: APIDefinition {
        let urlInfo: URLInfo = .HTTPBin(path: "/get")
        let requestInfo = RequestInfo<EmptyParameter>()
        let method: URLMethod = .get

        init() {}

        struct Response: Decodable {
            let hello: String
        }
    }
}

class ErrorSessionDataTaskService1: SessionDataTaskServicable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, Int?, Error?) -> Void) -> URLSessionDataTask
    {
        defer {
            let error = NSError(domain: "com.sample.app.testcode", code: 1)
            completionHandler(nil, 400, error)
        }

        return URLSession.shared.dataTask(with: .init(url: URL(string: "https://google.com")!))
    }
}

class ErrorSessionDataTaskService2: SessionDataTaskServicable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, Int?, Error?) -> Void) -> URLSessionDataTask
    {
        defer {
            completionHandler(nil, 400, nil)
        }

        return URLSession.shared.dataTask(with: .init(url: URL(string: "https://google.com")!))
    }
}

class ErrorSessionDataTaskService3: SessionDataTaskServicable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, Int?, Error?) -> Void) -> URLSessionDataTask
    {
        defer {
            completionHandler(nil, 200, nil)
        }

        return URLSession.shared.dataTask(with: .init(url: URL(string: "https://google.com")!))
    }
}

class ErrorSessionDataTaskService4: SessionDataTaskServicable {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, Int?, Error?) -> Void) -> URLSessionDataTask
    {
        defer {
            let data = "{\"hello1\": \"world\"".data(using: .utf8)
            completionHandler(data, 200, nil)
        }

        return URLSession.shared.dataTask(with: .init(url: URL(string: "https://google.com")!))
    }
}
