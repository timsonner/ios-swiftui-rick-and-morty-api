//
//  DetailSideView.swift
//  DetailSideView
//
//  Created by Timothy Sonner on 10/29/21.
//

import SwiftUI

struct DetailSideView: View {
   
        let result: Result
        
        var body: some View {
            
            VStack (alignment: .leading, spacing: 6) {
                        Text("Species: " + result.species + result.type)
                        Text("Gender: \(result.gender.rawValue)")
                        Text("Status: \(result.status.rawValue)")
                        Text("ID: \(result.id)")
                    }
                    .font(.callout)
                    .foregroundColor(.secondary)
//                    .padding()
                    Spacer()

                   
                
            }
    
}

struct DetailSideView_Previews: PreviewProvider {
    static var previews: some View {
        DetailSideView(result: Result(id: 94, name: "Diane Sanchez", status: .unknown, species: "Human", type: "", gender: .female, origin: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), location: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), image: "https://rickandmortyapi.com/api/character/avatar/94.jpeg", episode: ["https://rickandmortyapi.com/api/episode/22"], url: "https://rickandmortyapi.com/api/character/94", created: "2017-12-01T11:49:43.929Z"))
    }
}
