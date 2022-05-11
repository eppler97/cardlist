//
//  ContentView.swift
//  CardList2.0
//
//  Created by Bryce Eppler on 2022-05-10.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var dataStore: DataStore
    @State private var modalType: ModalType? = nil
    var body: some View {
        NavigationView {
            List() {
                ForEach(dataStore.cardList.sorted(by: {$0.dateAdded! > $1.dateAdded!})) { card in
                    Button {
                        modalType = .update(card)
                    } label: {
                        AsyncImage(
                            url: URL(string:card.image_uris.png),
                            content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                            },
                            placeholder: {
                                ProgressView()
                            }
                        )
                        Text(card.name)
                            .fontWeight(.bold)
                            .kerning(1.2)
                            .lineLimit(2)
                            .minimumScaleFactor(0.7)
                            .padding(.horizontal)
                        Text("$\(card.prices.usd) USD")
                            .padding(.horizontal)
                        Text(card.dateAdded!)
                            .font(.subheadline)
                            .fontWeight(.light)
                            .foregroundColor(.secondary)
                            .padding(.horizontal)
                            .padding(.bottom)
                        
                    }
                }
                .onDelete(perform: dataStore.deleteCard)
            }
            
            .listStyle(InsetGroupedListStyle())
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("My Buylist")
                        .font(.headline)
                        .foregroundColor(.orange)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        modalType = .new
                    } label: {
                        Image(systemName: "plus.circle.fill")
                    }
            
                }
            }
            
            .sheet(item: $modalType) { $0 }
            .alert(item: $dataStore.appError) { appError in
                Alert(title: Text("Error"), message: Text(appError.error.localizedDescription))
            }
        }.foregroundColor(.orange)

        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(DataStore())
    }
}
