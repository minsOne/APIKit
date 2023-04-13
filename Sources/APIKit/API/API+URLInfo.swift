//
//  API+URLInfo.swift
//
//
//  Created by minsOne on 2023/04/13.
//

import Foundation

public extension API {
    struct URLInfo {
        let scheme: String
        let host: String
        let port: Int?
        let path: String
        let query: [String: String]?

        public init(scheme: String = "https",
                    host: String,
                    port: Int? = nil,
                    path: String,
                    query: [String: String]? = nil)
        {
            self.scheme = scheme
            self.host = host
            self.port = port
            self.path = path
            self.query = query
        }
    }
}

extension API.URLInfo {
    var url: URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        components.queryItems = query?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }

        guard let url = components.url else {
            assertionFailure("URL 정보를 확인해주세요.")
            return .init(string: "https://\(host)")!
        }
        return url
    }
}
