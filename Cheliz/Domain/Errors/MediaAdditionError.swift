//
//  MediaAdditionError.swift
//  Cheliz
//
//  Created by SC on 3/17/25.
//

import Foundation

enum MediaAdditionError: Error, LocalizedError {
    case alreadyExists
    case databaseError
    case unknown
    
    var title: String {
        switch self {
            case .alreadyExists:
                return Notice.sameMediaAlreadyExistsTitle
            case .databaseError, .unknown:
                return Notice.errorTitle
        }
    }
    
    var errorDescription: String {
        switch self {
            case .alreadyExists:
                return Notice.sameMediaAlreadyExistsMessage
            case .databaseError, .unknown:
                return Notice.errorInAddMessage
        }
    }
}
