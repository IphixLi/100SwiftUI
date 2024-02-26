//
//  ContentView.swift
//  WordScramble
//
//  Created by Iphigenie Bera on 2/25/24.
//

import SwiftUI

struct ContentView: View {
    let people = ["Finn", "Leia", "Luke", "Rey"];

    var body: some View {
        List{
            Text("Static Row")
            ForEach(people, id: \.self) {
                Text($0)
            }
        }
    }
        
    func testBundles(){
            if let fileURL = Bundle.main.url(forResource: "some-file", withExtension: "txt") {
                if let fileContents = try? String(contentsOf: fileURL) {
                        // we loaded the file into a string!
                    }
            }
                
        }
    
    func testStrings(){
        let input="a b c"
        let letters=input.components(separatedBy: " ")
        let letter = letters.randomElement()
        let word = "swift"
        
        // trimming
        let trimmed = letter?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        //spelling check
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        let allGood = misspelledRange.location == NSNotFound

    }
    }


#Preview {
    ContentView()
}
