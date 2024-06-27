//
//  ContentView.swift
//  Bookworm
//  Created by Iphigenie Bera on 4/4/24.
//
import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var rating = 3
    @State private var genre = ""
    @State private var review = ""
    @State private var selectedGenre = ""
    @State private var showError=false
    @State private var errorMessage=""

    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Other"]

    var body: some View {
        NavigationStack{
            Form{
                Section{
                    TextField("name of Book", text:$title)
                    TextField("Author's name", text:$author)
                    
                    
                    Picker("Genre", selection:$selectedGenre){
                        ForEach(genres, id:\.self){
                            Text(String($0))
                        }
                    }
                    if selectedGenre == "Other" {
                        TextField("Enter Genre name: ", text: $genre)
                            .padding()
                    }
                }
            
                    
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section{
                    Button("Save"){
                        if title.isEmpty {
                            showError=true
                            errorMessage="Please enter title of Book"
                        }else if genre.isEmpty && selectedGenre == "Other" {
                            showError=true
                            errorMessage="Please enter specific genre type"
                        }else{
                            if author.isEmpty {
                                author="Unknown"
                            }
                            if selectedGenre != "Other"{
                                genre = selectedGenre
                            }
                            
                            let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                            modelContext.insert(newBook)
                            dismiss()
                        }
                        
                    }
                    if showError{
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }
                    
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
}

#Preview {
    AddBookView()
}
