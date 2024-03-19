//
//  ContentView.swift
//  Moonshot
//
//  Created by Iphigenie Bera on 3/6/24.
//

import SwiftUI



struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    @State private var showingGrid = false;
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns){
                    ForEach(missions){ mission in
                        NavigationLink(value: mission){
                            VStack{
                                Image(mission.image)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width:100, height: 100)
                                    .padding()
                                
                                VStack {
                                    Text(mission.displayName)
                                        .font(.headline)
                                        .foregroundStyle(.white)
                                    Text(mission.formattedLaunchDate)
                                        .font(.caption)
                                        .foregroundStyle(.white.opacity(0.5))
                                }
                                .padding(.vertical)
                                .frame(maxWidth: .infinity)
                                .background(.lightBackground)
                                
                            }
                        }
                        .navigationDestination(for:Mission.self) {mission in
                            MissionView(mission: mission, astronauts: astronauts)
                        }
                    }
                }
            }
                .preferredColorScheme(.dark)
                .navigationTitle("Moonshot")
                .background(.darkBackground)
                .clipShape(.rect(cornerRadius: 10))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.lightBackground))
                .padding([.horizontal, .bottom])
            

        }
    }
}

#Preview {
    ContentView()
}

