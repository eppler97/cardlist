//
//  asdasd.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-10.
//

import SwiftUI

struct CardFormView: View {
    @EnvironmentObject var dataStore: DataStore
    @ObservedObject var formVM: CardFormViewModel
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                formVM.updating ? nil : HStack {
                    TextField("Card name", text: $formVM.inputStr)
                        .onSubmit {
                            formVM.searchCard()
                        }
                }
                VStack {
                    if (formVM.image_uris != nil) {
                        Text(formVM.name!)
                            .fontWeight(.bold)
                            .kerning(1.2)
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                            .padding(.horizontal)
                        Text("$\(formVM.prices!.usd) USD")
                            .padding(.horizontal)
                        AsyncImage(
                            url: URL(string:formVM.image_uris!.png),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                    }
                }
 
     

            }
            .navigationTitle("Card")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(leading: cancelButton, trailing: saveButton)
        }

    }
}

extension CardFormView {

    func addCard() {
        let card = Card(name: formVM.name!, image_uris: formVM.image_uris!, prices: formVM.prices!, dateAdded: formVM.dateAdded)
        dataStore.addCard(card)
        presentationMode.wrappedValue.dismiss()
    }
    
    var cancelButton: some View {
        Button("Cancel") {
            presentationMode.wrappedValue.dismiss()
        }
    }
    
    var saveButton: some View {
        formVM.updating ? nil : Button( "Add Card" ) {
            formVM.updating ? presentationMode.wrappedValue.dismiss() : addCard()
        }
        .disabled(!formVM.isDisabled)
    }
    
}

struct CardFormView_Previews: PreviewProvider {
    static var previews: some View {
        CardFormView(formVM: CardFormViewModel())
            .environmentObject(DataStore())
    }
}
