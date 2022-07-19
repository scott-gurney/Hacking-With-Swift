//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Scott Gurney on 19/07/2022.
//

import SwiftUI

enum predicateType: String {
    case fullName
    case shortName
}

func getPredicate(predicate: predicateType) -> String {
    if predicate == predicateType.fullName {
        return "fullName BEGINSWITH %@"
    }
    else if predicate == predicateType.shortName {
        return "shortName BEGINSWITH %@"
    }
    else {
        return ""
    }
}

struct FilteredList: View {
    @FetchRequest var fetchRequest: FetchedResults<Country>
    
    init(sort: [SortDescriptor<Country>], term: predicateType, filter: String) {
        _fetchRequest = FetchRequest<Country>(sortDescriptors: sort, predicate: NSPredicate(format: getPredicate(predicate: term), filter))
    }
    
    var body: some View {
        List(fetchRequest, id: \.self) { country in
            Section(country.wrappedFullName) {
                ForEach(country.candyArray, id: \.self) { candy in
                    Text(candy.wrappedName)
                }
            }
        }
        
    }
}
