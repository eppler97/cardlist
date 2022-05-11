//
//  DataStore.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-10.
//

import Foundation

class DataStore: ObservableObject {
    @Published var cardList:[Card] = []
    @Published var appError: ErrorType? = nil
    
    init() {
        print(FileManager.docDirURL.path)
        if FileManager().docExist(named: fileName) {
            loadCards()
        }
    }
    
    func addCard(_ card: Card) {
        cardList.append(card)
        saveCards()
    }
    func deleteCard(at indexSet: IndexSet) {
        cardList.remove(atOffsets: indexSet)
        saveCards()
    }
    func loadCards() {
        // cardList = Card.sampleData
        FileManager().readDocument(docName: fileName) { (result) in
            switch result {
            case .success(let data):
                let decoder = JSONDecoder()
                do {
                    cardList = try decoder.decode([Card].self, from: data)
                } catch {
//                    print(CardError.decodingError.localizedDescription)
                    appError = ErrorType(error: .decodingError)
                }
            case .failure(let error):
//                print(error.localizedDescription)
                appError = ErrorType(error: error)
            }
        }
    }
    func saveCards() {
        print("Saved cards to file system eventually")
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(cardList)
            let jsonString = String(decoding: data, as: UTF8.self)
            FileManager().saveDocument(contents: jsonString, docName: fileName) { (error) in
                if let error = error {
//                    print(error.localizedDescription)
                    appError = ErrorType(error: error)
                }
            }
        } catch {
//            print(CardError.encodingError.localizedDescription)
            appError = ErrorType(error: .encodingError)
        }
    }
}

