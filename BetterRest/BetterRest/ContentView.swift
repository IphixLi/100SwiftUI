//
//  ContentView.swift
//  BetterRest
//
//  Created by Iphigenie Bera on 2/24/24.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount=8.0;
    @State private var wakeUp=defaultWakeTime
    @State private var coffeAmount=1
    
    @State private var alertTitle=""
    @State private var alertMessage=""
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date{
        var components=DateComponents()
        components.hour=7
        components.minute=0
        
        return Calendar.current.date(from: components) ?? .now
    }
    
    
    
    
    var body: some View{
        NavigationStack {
            Form {
                Section(header:Text("Wake up time")) {
                    Text("When do you want to wake up?")
                        .font(.headline)

                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                }

                Section(header:Text("Sleet amount")) {
                    Text("Desired amount of sleep")
                        .font(.headline)

                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                }

                Section(header:Text("Coffee  intake")) {
                    Text("Daily coffee intake")
                        .font(.headline)

//                    Stepper("^[\(coffeAmount) cup](inflect:true)", value: $coffeAmount, in: 1...20)
//                    
                    Picker("number of cups: ", selection:$coffeAmount){
                        ForEach(1..<21){
                            Text("\($0) cups")
                        }
                    }
                    .pickerStyle(.navigationLink)   //navigation style
                }
                
//                Section(header:Text("recommended sleep").font(.title)){
//                    Text(
//                    
//                }
            }
            .navigationTitle("BetterRest")
            .toolbar {
                Button("Calculate", action: calculateBedtime)
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    func calculateBedtime() {
        do{
            let config=MLModelConfiguration()
            let model=try SleepCalculator(configuration:config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60

            
            let prediction = try model.prediction(wake:Double(hour+minute), estimatedSleep:sleepAmount, coffee:Double(coffeAmount))
            
            let sleepTime=wakeUp - prediction.actualSleep
            alertTitle = "Your ideal bedtime is…"
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
            
        }catch{
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
        showingAlert = true
        
    }
    
}

#Preview {
    ContentView()
}
