//
//  CrewView.swift
//  Moonshot
//
//  Created by Iphigenie Bera on 3/15/24.
//

import SwiftUI

struct CrewView: View {
    let crew: [CrewMember]
    var body: some View {
        HStack{
            ForEach(crew, id:\.role){crewMember in
                NavigationLink{
                    AstronautView(astronaut: crewMember.astronaut)
                }label:{
                    HStack{
                        Image(crewMember.astronaut.id)
                            .resizable()
                            .frame(width: 104, height:72)
                            .clipShape(.capsule)
                            .overlay(
                            Capsule()
                                .stroke(.white, lineWidth:1))
                        
                        VStack(alignment: .leading){
                            Text(crewMember.astronaut.name)
                                .foregroundStyle(.white)
                                .font(.headline)
                            Text(crewMember.role)
                                .foregroundStyle(.white.opacity(0.5))
                        }
                    }
                    .padding(.horizontal)
                }
    
            }
        }
    }
}

