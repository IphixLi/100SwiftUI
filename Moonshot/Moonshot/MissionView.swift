//
//  MissionView.swift
//  Moonshot
//
//  Created by Iphigenie Bera on 3/12/24.
//

import Foundation
import SwiftUI

struct CrewMember {
    let role: String
    let astronaut: Astronaut
}


struct MissionView: View{
    let mission: Mission

    let crew: [CrewMember]
    
    init(mission: Mission, astronauts: [String: Astronaut]){
        self.mission=mission
        self.crew=mission.crew.map{ member in
            if let astronaut = astronauts[member.name]{
                return CrewMember(role:member.role, astronaut: astronaut)
            }else{
                fatalError("Mission \(member.name)")
            }}
    }
    
    
    var body: some View {
        ScrollView{
            VStack{
                Image(mission.image)
                    .resizable()
                    .scaledToFit()
                    .containerRelativeFrame(.horizontal){
                        width, axis in width*0.6
                    }
                    .padding(.top)
                
                Text(mission.formattedLaunchDate)
                    .font(.subheadline)
    
                
                VStack(alignment: .leading){
                    Text("Mission Highlights")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text(mission.description)
                    
                    Rectangle()
                        .frame(height: 2)
                        .foregroundStyle(.lightBackground)
                        .padding(.vertical)
                    
                    Text("Crew")
                        .font(.title.bold())
                        .padding(.bottom, 5)
                }
                .padding(.bottom)
                ScrollView(.horizontal, showsIndicators:false){
                    CrewView(crew: crew)
                }
                
            }
            .navigationTitle(mission.displayName)
            .navigationBarTitleDisplayMode(.inline)
            .background(.darkBackground)
        }
    }
}

#Preview {
    let missions: [Mission] = Bundle.main.decode("missions.json")
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    return MissionView(mission: missions[0], astronauts: astronauts)
        .preferredColorScheme(.dark)
}
