//
//  APIDefinition.swift
//
//
//  Created by minsOne on 2023/04/13.
//

import Foundation

public protocol APIDefinition {
    typealias URLInfo = API.URLInfo
    typealias RequestInfo = API.RequestInfo

    associatedtype Parameter: Parameterable
    associatedtype Response: Decodable

    var urlInfo: URLInfo { get }
    var requestInfo: RequestInfo<Parameter> { get }
    var method: URLMethod { get }
}
