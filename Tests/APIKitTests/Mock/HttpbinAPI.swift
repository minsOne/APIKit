//
//  File.swift
//
//
//  Created by minsOne on 2023/04/13.
//

import APIKit
import Foundation

extension API.URLInfo {
    static func HTTPBin(path: String) -> Self {
        Self(host: "httpbin.org", path: path)
    }
}

enum HTTPBin {}

extension HTTPBin {
    struct Get: APIDefinition {
        let urlInfo: URLInfo
        let requestInfo: RequestInfo<EmptyParameter> = .init(method: .get)

        init() {
            self.urlInfo = .HTTPBin(path: "/get")
        }

        struct Response: Decodable {
            let args: [String: String]
            let headers: [String: String]
            let origin: String
            let url: String
        }
    }
}

extension HTTPBin {
    struct Post: APIDefinition {
        let urlInfo: URLInfo
        let requestInfo: RequestInfo<Parameter>

        init(parameter: Parameter) {
            self.urlInfo = .HTTPBin(path: "/post")
            self.requestInfo = .init(method: .post, parameters: parameter)
        }

        struct Parameter: Parameterable {
            let name: String
            let age: String
            init(name: String, age: String) {
                self.name = name
                self.age = age
            }
        }

        struct Response: Decodable {
            let args: [String: String]
            let data: String
            let files: [String: String]
            let form: [String: String]
            let headers: [String: String]
            let json: String?
            let origin: String
            let url: String
        }
    }
}
