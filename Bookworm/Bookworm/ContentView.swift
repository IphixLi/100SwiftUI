//
//  ContentView.swift
//  Bookworm
//
//  Created by Iphigenie Bera on 4/4/24.
//
import SwiftData
import SwiftUI



struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.title, order: .reverse),
        SortDescriptor(\Book.author)
                 ]) var books: [Book]
    
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationStack {
            List{
                ForEach(books){ book in
                    NavigationLink(value: book){
                        HStack{
                            EmojiRatingView(rating: book.rating)
                                .font(.largeTitle)
                            
                            VStack(alignment: .leading){
                                Text(book.title)
                                    .font(.headline)
                                    .foregroundColor(book.rating==1 ?.red : .black )
                                Text(book.author)
                                    .foregroundStyle(.secondary)
                            }
                        }
                    }
                }
                .onDelete(perform: deleteBooks)
            }.navigationTitle("Bookworm")
                .navigationDestination(for: Book.self) { book in
                    DetailView(book: book)
                }
            
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Add Book", systemImage: "plus") {
                            showingAddScreen.toggle()
                        }
                    }
                    
                    ToolbarItem(placement: .topBarLeading){
                        EditButton()
                    }
                }
                .sheet(isPresented: $showingAddScreen) {
                    AddBookView()
                }
        }
    }
        
    func deleteBooks(at offsets: IndexSet){
            for offset in offsets {
                //find this book in our query
                let book = books[offset]

                // delete it from the context
                modelContext.delete(book)
            }
    }
    
    
    
}

#Preview {
    ContentView()
}
