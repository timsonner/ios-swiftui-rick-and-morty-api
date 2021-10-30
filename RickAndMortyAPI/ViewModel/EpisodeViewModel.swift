//
//  EpisodeViewModel.swift
//  EpisodeViewModel
//
//  Created by Timothy Sonner on 10/29/21.
//

import Foundation

@MainActor
class EpisodeViewModel: ObservableObject {
    
    enum State {
        case initialState
        case loading
        case successLoadingEpisodes(data: [CurrentEpisodeViewModel])
        case failed(error: Error)
    }
    
    @Published private(set) var state: State = .initialState
    // set means changes to this var can only be made from within scope of this class. views can't directly change this var, only reflect its change
    @Published var hasError: Bool = false
    @Published var currentEpisodes: [CurrentEpisodeViewModel] = []
    
    private let webService: WebService  // dependency injection
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func populateEpisodes(url: String) async {
        do {
            let currentEpisode = try await webService.fetchEpisode(url: url) // fetch data from API
            if let episode = currentEpisode {
                let currentEpisodeViewModel = CurrentEpisodeViewModel(id: episode.id, name: episode.name, airDate: episode.airDate, episode: episode.episode) // create instance of view model with data injected
                self.currentEpisodes.append(currentEpisodeViewModel) // update the array of view model objects
                self.state = .successLoadingEpisodes(data: currentEpisodes)
            }
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
    
    struct CurrentEpisodeViewModel: Identifiable {
        
        let id: Int
        let name: String
        let airDate: String
        let episode: String
        //        let id: Int
        //        let name, airDate, episode: String
        //        let characters: [String]
        //        let url: String
        //        let created: String
        //
    }
    
}
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    //func populateCharacters(page: String, name: String) async {
    //    do {
    //        let currentCharacter = try await webService.NetworkRequest(page: page, name: name) // fetch data from API
    //            if let currentCharacter = currentCharacter {
    //                for character in currentCharacter {
    //                    let currentCharacterViewModel = CurrentCharacterViewModel(currentCharacter: character) // create instance of view model with data injected
    //                    self.currentCharacters.append(currentCharacterViewModel) // update the array of view model objects
    //                }
    //                if name.isEmpty {
    //                self.state = .success(data: currentCharacters)
    //            } else {
    //                self.state = .success(data: currentCharacters.filter {$0.name.contains(name)})
    //            }
    //        }
    //    } catch {
    //        self.state = .failed(error: error)
    //        self.hasError = true
    //    }
    //}
