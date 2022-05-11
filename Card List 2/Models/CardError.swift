//
//  CardError.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-11.
//

import Foundation

enum CardError: Error, LocalizedError {
    case saveError
    case readError
    case decodingError
    case encodingError
    
    var errorDescription: String? {
        switch self {
        case .decodingError: return NSLocalizedString("There was a problem loading cards, please add a new card to start over.", comment: "")
        case .encodingError: return NSLocalizedString("Could not save Cards, please reinstall the app.", comment: "")
        case .readError: return NSLocalizedString("Could not load Cards, please reinstall the app.", comment: "")
        case .saveError: return NSLocalizedString("Could not save Cards, please reinstall the app.", comment: "")
        }
    }
}

struct ErrorType: Identifiable {
    let id = UUID()
    let error: CardError
}
