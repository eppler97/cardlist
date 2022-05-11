//
//  CardFormViewModel.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-10.
//

import Foundation

class CardFormViewModel: ObservableObject {
    // Create card object to
    @Published var inputStr = ""
    @Published var name: String?
    @Published var image_uris: CardImages?
    var prices: CardPrices?
    var dateAdded: String?
    var id: String?
    
    var updating: Bool {
        id != nil
    }
    
    var isDisabled: Bool {
        ((name?.isEmpty) != nil)
    }
    
    
    init() {}
    
    init(_ currentCard: Card) {
        self.name = currentCard.name
        self.image_uris = currentCard.image_uris
        self.prices = currentCard.prices
        self.dateAdded = currentCard.dateAdded
        self.id = currentCard.id
    }
    
    
    func searchCard() {
        getData(from: getUrl(inputString: self.inputStr))
    }

    func getUrl(inputString: String) -> String {
        // inputString = "Dockside Extort"
        // returns https://api.scryfall.com/cards/named?fuzzy=dockside+extort
        var urlStr: String = "https://api.scryfall.com/cards/named?fuzzy="
        let inputStringArr = inputString.components(separatedBy: " ")
        for word in inputStringArr {
            if word != inputStringArr[0] {
                urlStr.append("+")
            }
            urlStr.append("\(word)")
        }
        return urlStr
    }
    
    
    func getData(from url: String) {
        // Given a Scryfall API URL, retrieve the data and map to a new card object
        URLSession.shared.dataTask(with: URL(string: url)!, completionHandler: { data, response, error in
            
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // decode json data
            var result: Card?
            
            do {
                result = try JSONDecoder().decode(Card.self, from: data)
            }
            catch {
                print("failed to covert \(error.localizedDescription)")
            }
            
            guard let json = result else {
                return
            }
            let date = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, YYYY"             // Oct 29, 2020
            self.name = json.name
            self.image_uris = json.image_uris
            self.prices = json.prices
            self.dateAdded = dateFormatter.string(from: date)
            print("\(json.name) appended to list")
            
        }).resume()
        
    }
}
