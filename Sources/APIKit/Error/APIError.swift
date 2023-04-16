//
//  File.swift
//  
//
//  Created by minsOne on 2023/04/13.
//

import Foundation

public enum APIError: Error {
    case emptyResponse
    case error(Error)
    case invalidateError
    
    static func statusCodeError(statusCode code: Int) -> APIError? {
        switch code {
        case 200 ..< 300: return nil
        default: return .invalidateError
        }
    }
}
