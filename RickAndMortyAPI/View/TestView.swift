//
//  TestView.swift
//  RickAndMortyAPI
//
//  Created by Timothy Sonner on 10/29/21.
//

import SwiftUI

// https://rickandmortyapi.com/api/episode/22

struct TestView: View {
    
    @StateObject var episodeVM = EpisodeViewModel(webService: WebService())
    
    var body: some View {
    switch episodeVM.state {
    case .successLoadingEpisodes(let data):
        ForEach(data) {
            episode in
            Text(episode.name)
                
        }
        
        
    
    default:
        Text("default")
            .alert("Error",
                   isPresented: $episodeVM.hasError,
                   presenting: episodeVM.state) { errorDetails in
                Button("Retry") {
                    Task {
                        await episodeVM.populateEpisodes(url: "https://rickandmortyapi.com/api/episode/22")
                    }
                }
            } message: { errorMessage in
                if case let .failed(error) = errorMessage {
                    Text(" \(error.localizedDescription)")
                }
            } // MARK: - End of Error Alert
            // MARK: First action of view
            .task {
                await episodeVM.populateEpisodes(url: "https://rickandmortyapi.com/api/episode/22")
            }
    }
}
    
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
