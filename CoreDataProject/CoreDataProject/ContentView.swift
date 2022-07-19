//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Scott Gurney on 19/07/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var countries: FetchedResults<Country>
    let terms = [predicateType.fullName, predicateType.shortName]    
    
    let sort = [
        SortDescriptor(\Country.fullName, order: .reverse)
    ]

    
    @State private var countryFilter = ""
    @State private var term = predicateType.fullName

    var body: some View {
        VStack {
            FilteredList(sort: sort, term: term, filter: countryFilter)
            
            Button("Add") {
                let candy1 = Candy(context: moc)
                candy1.name = "Mars"
                candy1.origin = Country(context: moc)
                candy1.origin?.shortName = "UK"
                candy1.origin?.fullName = "United Kingdom"
                
                let candy2 = Candy(context: moc)
                candy2.name = "KitKat"
                candy2.origin = Country(context: moc)
                candy2.origin?.shortName = "UK"
                candy2.origin?.fullName = "United Kingdom"
                
                let candy3 = Candy(context: moc)
                candy3.name = "Twix"
                candy3.origin = Country(context: moc)
                candy3.origin?.shortName = "UK"
                candy3.origin?.fullName = "United Kingdom"
                
                let candy4 = Candy(context: moc)
                candy4.name = "Toblerone"
                candy4.origin = Country(context: moc)
                candy4.origin?.shortName = "CH"
                candy4.origin?.fullName = "Switzerland"
                
                let candy5 = Candy(context: moc)
                candy5.name = "Herseys Kisses"
                candy5.origin = Country(context: moc)
                candy5.origin?.shortName = "USA"
                candy5.origin?.fullName = "United States of America"
                
                try? moc.save()
            }
//
//            Button("Just UK") {
//                countryFilter = "U"
//            }
//
//            Button("Just Switzerland") {
//                countryFilter = "S"
//            }
            
            Picker("Pick search type", selection: $term) {
                ForEach(terms, id:\.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)

            
            TextField("Enter search term", text: $countryFilter)
                .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
