//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Bengi Anıl on 24.10.2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>

    var body: some View {
        VStack {
            List {
                ForEach(countries, id: \.self) { country in
                    Section(country.wrappedFullName) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            
            Button("Add") {
                 let candy1 = Candy(context: self.moc)
                 candy1.name = "Mars"
                 candy1.origin = Country(context: self.moc)
                 candy1.origin?.shortName = "UK"
                 candy1.origin?.fullName = "United Kingdom"

                 let candy2 = Candy(context: self.moc)
                 candy2.name = "KitKat"
                 candy2.origin = Country(context: self.moc)
                 candy2.origin?.shortName = "UK"
                 candy2.origin?.fullName = "United Kingdom"

                 let candy3 = Candy(context: self.moc)
                 candy3.name = "Twix"
                 candy3.origin = Country(context: self.moc)
                 candy3.origin?.shortName = "UK"
                 candy3.origin?.fullName = "United Kingdom"

                 let candy4 = Candy(context: self.moc)
                 candy4.name = "Toblerone"
                 candy4.origin = Country(context: self.moc)
                 candy4.origin?.shortName = "CH"
                 candy4.origin?.fullName = "Switzerland"

                 try? self.moc.save()
             }
        }
    }
}

#Preview {
    ContentView()
}
