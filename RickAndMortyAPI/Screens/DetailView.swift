//
//  DetailView.swift
//  DetailView
//
//  Created by Timothy Sonner on 10/23/21.
//

import SwiftUI

struct DetailView: View {
    
    var result: Result
    var body: some View {
        VStack {
            HStack(spacing: 24) {
            AsyncImageView(image: result.image)
            DetailSideView(result: result)
        }
            .padding()
        DetailBottomView(result: result)
            Spacer()
    }
        .padding()
                .navigationBarTitle(result.name)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(result: Result(characterID: 94, name: "Diane Sanchez", status: .unknown, species: "Human", type: "", gender: .female, origin: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), location: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), image: "https://rickandmortyapi.com/api/character/avatar/94.jpeg", episode: ["https://rickandmortyapi.com/api/episode/22"], url: "https://rickandmortyapi.com/api/character/94", created: "2017-12-01T11:49:43.929Z"))
    }
}




