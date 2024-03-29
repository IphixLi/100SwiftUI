//
//  ContentView.swift
//  WordScramble
//
//  Created by Iphigenie Bera on 2/25/24.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords=[String]()
    @State private var rootWord=""
    @State private var newWord=""
    
    @State private var errorTitle=""
    @State private var errorMessage=""
    @State private var showingError=false
    
    
    // challenge3
    @State private var letter_count=0
    @State private var word_count=0
    
    func wordError(title:String, message:String){
        errorTitle=title
        errorMessage=message
        showingError=true
    }
    
    var body: some View {
        NavigationStack{
            List{
                
                Section("Score"){
                    HStack{
                        Text("word count:")
                        Text("\(word_count)")
                    }
                    HStack{
                        Text("letter count:")
                        Text("\(letter_count)")
                    }
                }
                
                
                Section{
                    TextField("Enter your word", text:$newWord)
                        .textInputAutocapitalization(.never)
                }
                
                Section{
                    ForEach(usedWords, id:\.self){word in
                        HStack{
                            Image(systemName: "\(word.count).circle")
                            Text(word)}
                    }
                }
                
            }.navigationTitle(rootWord)
            .onSubmit {
                        addNewWord()
                    }
            .onAppear(perform:startGame)
            .alert(errorTitle, isPresented:$showingError){
                Button("OK"){}
            }message:{
                Text(errorMessage)
            }
            .toolbar{
                ToolbarItem(placement: .bottomBar){
                    Button("Restart Game"){
                        print("hahahaha")
                        startGame()
                    }
                }
            }
        }
    }
    
    
    func addNewWord(){
        let answer=newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        
        guard answer.count>0 else{
            print(answer)
            return }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard answer.utf8.count >= 3 else{
            wordError(title: "Short word", message: "Word should be atleast 3 characters")
            return
        }

        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from '\(rootWord)'!")
            return
        }

        guard isReal(word: answer) else {
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }

        
        withAnimation{
            usedWords.insert(answer, at:0)
            newWord=""
            word_count+=1
            letter_count+=answer.utf16.count
        }
    }
    
    func startGame(){
        
        if let startWordsURL=Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords=try? String(contentsOf:startWordsURL){
                
                let allWords=startWords.components(separatedBy: "\n")
                
                rootWord=allWords.randomElement() ?? "silkworm"
                
                word_count=0
                letter_count=0
                print(rootWord)
                return
            }
            
        }
        fatalError("Could not load start.txt from bundle.")
    }
    
    func lessthanthree(word:String)->Bool{
        if word.utf16.count<=3{
            return true
        }
        return false
    }
    
    func isOriginal(word: String)->Bool{
        !usedWords.contains(word)
    }
    
    func isPossible(word: String)->Bool{
        var tempWord=rootWord
        
        for letter in word{
            if let pos = tempWord.firstIndex(of:letter){
                tempWord.remove(at:pos)
            }else{
                return false
            }
        }
        
        return true
}
    
    func isReal(word:String)->Bool{
        let checker=UITextChecker()
        let range=NSRange(location: 0, length: word.utf16.count)
        let misspelledRange=checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location==NSNotFound
    }
    
    
    
    
}


#Preview {
    ContentView()
}
