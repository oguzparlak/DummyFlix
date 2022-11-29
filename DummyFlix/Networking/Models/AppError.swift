//
//  NetworkError.swift
//  Networking
//
//  Created by Oğuz Parlak on 15.09.2020.
//  Copyright © 2020 Oğuz Parlak. All rights reserved.
//

import Foundation

public enum AppError: Error {
    case authentication(code: String)
    case custom(code: String)
    case notFound(code: String)
		case authorization(code: String)
    case unableToDecode
    case unknown
		case ignorable
}

extension AppError: LocalizedError {

    public var errorDescription: String? {
        switch self {
        case .unableToDecode:
            return "Mapping error"
        case .unknown:
            return "Unkown error occured"
        case .authentication(let message):
            return message
        case .custom(let message):
            return message
        case .notFound(let message):
            return message
				case .authorization(let message):
						return message
				case .ignorable:
					return ""
        }
    }

}
