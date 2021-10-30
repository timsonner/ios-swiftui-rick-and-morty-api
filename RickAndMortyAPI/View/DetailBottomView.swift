//
//  DetailBottomView.swift
//  DetailBottomView
//
//  Created by Timothy Sonner on 10/29/21.
//

import SwiftUI

struct DetailBottomView: View {
    var result: Result
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8) {
            Text("Last known location:")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text(result.location.name)
                .font(.headline)
            Text("First seen in:")
                .font(.subheadline)
                .foregroundColor(.secondary)
            Text("\(result.episode[0])")
                .font(.headline)
            
            Divider()
            VStack {
                Text("Appears in episodes:")
                    .font(.title3)
                List {
                    ForEach(result.episode, id: \.self) {
                        episode in
                        Link(destination: URL(string: episode)!, label: {
                            Text(episode)
                        }
                        )
                        
                    }
                }
                
            }
        }
        .padding()
    }
}

struct DetailBottomView_Previews: PreviewProvider {
    static var previews: some View {
        DetailBottomView(result: Result(id: 94, name: "Diane Sanchez", status: .unknown, species: "Human", type: "", gender: .female, origin: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), location: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), image: "https://rickandmortyapi.com/api/character/avatar/94.jpeg", episode: ["https://rickandmortyapi.com/api/episode/22"], url: "https://rickandmortyapi.com/api/character/94", created: "2017-12-01T11:49:43.929Z"))
    }
}
