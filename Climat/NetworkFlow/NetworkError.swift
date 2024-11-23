//
//  NetworkError.swift
//  Climat
//
//  Created by Юлия Кагирова on 08.11.2024.
//

import UIKit

enum NetworkError: Error {
    case noData
    case serverError
    case parsingError
    
    var description: String {
        switch self {
        case .noData:
            return "No data"
        case .serverError:
            return "Server error"
        case .parsingError:
            return "Parsing error"
        }
    }
}
