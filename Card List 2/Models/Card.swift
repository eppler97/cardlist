//
//  CardObject.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-10.
//

import Foundation

struct Card: Identifiable, Codable {
    var id: String = UUID().uuidString
    var name: String
    var image_uris: CardImages
    var prices: CardPrices
    var dateAdded: String?
    
    static var sampleData: [Card] {
        [
            Card(name: "Dockside Extortionist", image_uris: CardImages(png: "https://c1.scryfall.com/file/scryfall-cards/png/front/5/7/571bc9eb-8d13-4008-86b5-2e348a326d58.png?1615499802", small: "", normal: ""), prices: CardPrices(usd: "66.51", usd_foil: ""), dateAdded:"Oct 29, 2020"),
            Card(name: "Dockside Extortionist", image_uris: CardImages(png: "https://c1.scryfall.com/file/scryfall-cards/png/front/5/7/571bc9eb-8d13-4008-86b5-2e348a326d58.png?1615499802", small: "", normal: ""), prices: CardPrices(usd: "66.51", usd_foil: ""), dateAdded:"Oct 29, 2020")
        ]
    }
}

struct CardImages: Codable {
    var png: String
    var small: String
    var normal: String
}

struct CardPrices: Codable {
    var usd: String
    var usd_foil: String?
}
