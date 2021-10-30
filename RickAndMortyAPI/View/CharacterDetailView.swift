//
//  CharacterDetailView.swift
//  CharacterDetailView
//
//  Created by Timothy Sonner on 10/23/21.
//

import SwiftUI

struct CharacterDetailView: View {
    
    var result: Result
    var body: some View {
        VStack {
        HStack {
            AsyncImageView(image: result.image)
            DetailSideView(result: result)
        }
        DetailBottomView(result: result)
            Spacer()
    }
        .padding(.top, 18)
                .padding(.horizontal, 20)
                .navigationBarTitle(result.name)
    }
}

struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView(result: Result(id: 94, name: "Diane Sanchez", status: .unknown, species: "Human", type: "", gender: .female, origin: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), location: Location(name: "Earth (Unknown dimension)", url: "https://rickandmortyapi.com/api/location/30"), image: "https://rickandmortyapi.com/api/character/avatar/94.jpeg", episode: ["https://rickandmortyapi.com/api/episode/22"], url: "https://rickandmortyapi.com/api/character/94", created: "2017-12-01T11:49:43.929Z"))
    }
}



