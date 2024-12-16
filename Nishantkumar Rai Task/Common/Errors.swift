//
//  Errors.swift
//  Nishantkumar Rai Task
//
//  Created by Nishant Rai on 15/12/24.


enum APIError: Error {
    case invalidURL
    case requestFailed(reason: String)
    case networkUnavailable(reason: String)
    case custom(message: String)
    
    var localizedErrorDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid API URL"
            
        case .requestFailed(let reason):
            return reason
            
        case .networkUnavailable(let reason):
            return reason
            
        case .custom(let message):
            return message
        }
    }
}
