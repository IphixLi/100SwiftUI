//
//  DetailView.swift
//  Bookworm
//
//  Created by Iphigenie Bera on 6/24/24.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottomTrailing) {
                genreImage(for: book.genre)
                    .resizable()
                    .scaledToFit()

                Text(book.genre.uppercased())
                    .font(.caption)
                    .fontWeight(.black)
                    .padding(8)
                    .foregroundStyle(.white)
                    .background(.black.opacity(0.75))
                    .clipShape(.capsule)
                    .offset(x: -5, y: -5)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert){
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel){}
        } message: {
            Text("Are you Sure?")
        }
        .toolbar{
            Button("Delete this book", systemImage:"trash"){
                showingDeleteAlert = true
            }
        }
        
        Text(book.author)
            .font(.title)
            .foregroundStyle(.secondary)
        
        HStack{
            Text("Date added: ")
            Text(book.date, format:.dateTime.hour().minute())
        }

        Text(book.review)
            .padding()
        
        RatingView(rating:.constant(book.rating))
            .font(.largeTitle)
        
    }
    
    func deleteBook(){
        modelContext.delete(book)
        dismiss()
    }
    
    func genreImage(for genre: String) -> Image {
        if let uiImage = UIImage(named: genre) {
            return Image(uiImage: uiImage)
        } else {
            let randomColor=UIColor(red:Double.random(in: 0...1),
                                    green:Double.random(in: 0...1),
                                    blue:Double.random(in: 0...1),
                                    alpha: 1.0)
            return Image(uiImage: UIImage(color: randomColor)!)
        }
    }
    
}

extension UIImage {
    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }

        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))

        guard let cgImage = UIGraphicsGetImageFromCurrentImageContext()?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
}

#Preview {
    do{
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Text Book", author: "Test Author", genre: "Fantasy", review:"This was an okay book fr", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    }
    catch{
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}

