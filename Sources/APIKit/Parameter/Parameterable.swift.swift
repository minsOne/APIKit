//
//  File.swift
//  
//
//  Created by minsOne on 2023/04/13.
//

import Foundation

public protocol Parameterable: Encodable {
    var dictionary: [String: Any]? { get }
}

public extension Parameterable {
    var dictionary: [String: Any]? {
        return (try? JSONEncoder().encode(self))
            .flatMap { try? JSONSerialization.jsonObject(with: $0) as? [String: Any] }
    }
}
