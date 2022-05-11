//
//  ModalType.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-11.
//

import SwiftUI

enum ModalType: Identifiable, View {
    case new
    case update(Card)
    var id: String {
        switch self {
        case .new:
            return "new"
        case .update:
            return "update"
        }
    }
    
    var body: some View {
        switch self {
        case .new:
            return CardFormView(formVM: CardFormViewModel())
        case .update(let card):
            return CardFormView(formVM: CardFormViewModel(card))
        }
    }
}
