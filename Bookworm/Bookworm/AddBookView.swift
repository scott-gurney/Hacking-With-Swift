//
//  AddBookView.swift
//  Bookworm
//
//  Created by Scott Gurney on 17/07/2022.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var review = ""
    @State private var genre = ""
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]

    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section {
                    TextField("Review", text: $review)
                    RatingView(rating: $rating)
                } header: {
                    Text("Write a review")
                }
                
                Section {
                    Button("Save") {
                        createBook()
                        try? moc.save()
                        dismiss()
                    }
                    .disabled(validateBook() == false)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    func createBook() {
        let newBook = Book(context: moc)
        
        newBook.id = UUID()
        newBook.title = title
        newBook.author = author
        newBook.genre = genre
        newBook.review = review
        newBook.rating = Int16(rating)
        newBook.date = Date.now
}
    
    func validateBook() -> Bool {
        if title.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            genre.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ||
            review.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        } else {
            return true
        }
    }
    
}

struct AddBookView_Previews: PreviewProvider {
    static var previews: some View {
        AddBookView()
    }
}
