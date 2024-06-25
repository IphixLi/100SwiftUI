
//  Created by Iphigenie Bera on 3/28/24.
//
import SwiftUI
import CoreHaptics
import Foundation

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable{
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct Haptics: View {
    @State private var counter = 0
    @State private var engine: CHHapticEngine?
    
    var body: some View {
        Button("Tap Count: \(counter)") {
            counter += 1
        }
        .sensoryFeedback(.increase, trigger: counter)
        // other haptic values can be .success, .warning, .error, .start, .stop
        
        //For example, we could request a middling collision between two soft objects:
        
        //.sensoryFeedback(.impact(flexibility: .soft, intensity: 0.5), trigger: counter)
        
        // fir nore haptics we can use Core Haptics
        
        Button("Tap Me", action: complexSuccess)
            .onAppear(perform: preparehaptics)
        
    }
    
    func preparehaptics(){
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
            do {
                engine = try CHHapticEngine()
                try engine?.start()
            } catch {
                print("There was an error creating engine: \(error.localizedDescription)")
            }
        }
    
    func complexSuccess(){
        // make sure device support haptics
        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
        
        var events = [CHHapticEvent]()
        
        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
            events.append(event)
        }

        for i in stride(from: 0, to: 1, by: 0.1) {
            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
            events.append(event)
        }
        
        // convert those events into a pattern and play it immediately
        do {
                let pattern = try CHHapticPattern(events: events, parameters: [])
                let player = try engine?.makePlayer(with: pattern)
                try player?.start(atTime: 0)
            } catch {
                print("Failed to play pattern: \(error.localizedDescription).")
            }
        
        
    }
    
}

//----------------------
struct DisableView: View {
    @State private var username = ""
    @State private var email = ""

    var body: some View {
        Form {
            Section {
                TextField("Username", text: $username)
                TextField("Email", text: $email)
            }

            Section {
                Button("Create account") {
                    print("Creating account…")
                }
            }
            .disabled(disableForm)
        }
    }
    
    var disableForm: Bool {
        username.count < 5 || email.count < 5
    }
    
}

//----------------
struct DataView: View {
    @State private var results=[Result]()
    
    var body: some View {
        Spacer()
//        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png"), scale:3)
//            .frame(width: 200, height: 200)
//
        AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")){ phase in
            if let image = phase.image{
                image
                    .resizable()
                    .scaledToFit()
            } else if phase.error != nil{
                Text("There was error loading image")
                
            }else{
                // Color.red
                // show spinning activity indicator
                ProgressView()
            }
        }
        .frame(width:200, height: 200)
        
        
        List(results, id:\.trackId){ item in
            VStack(alignment:.leading){
                Text(item.trackName)
                    .font(.headline)
                Text(item.collectionName)
            }}
        .task{
            await loadData()
        }
    }
    
    func loadData() async {
        
//        1. Creating the URL we want to read.
        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            print("Invalid URL")
            return
        }
        
//        2. Fetching the data for that URL.
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            //3. Decoding the result of that data into a Response struct.
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
            }
        } catch{
            print("Invalid data")
        }
        
    }
    
}

#Preview {
    Haptics()
}
