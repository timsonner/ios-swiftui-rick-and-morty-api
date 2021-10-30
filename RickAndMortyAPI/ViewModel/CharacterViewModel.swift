//
//  CharacterViewModel.swift
//  CharacterViewModel
//
//  Created by Timothy Sonner on 9/30/21.
//

import Foundation

@MainActor
class CharacterViewModel: ObservableObject {
    
    enum State {
        case initialState
        case loading
        case successLoadingCharacters(data: [CurrentCharacterViewModel])
        case failed(error: Error)
    }
    
    @Published private(set) var state: State = .initialState
    // set means changes to this var can only be made from within scope of this class. views can't directly change this var, only reflect its change
    @Published var hasError: Bool = false
    @Published var currentCharacters: [CurrentCharacterViewModel] = []
    @Published var searchText = ""
    @Published var rickAndMortyURL = "https://rickandmortyapi.com/api/character/?page=1&name="
    
    private let webService: WebService  // dependency injection
    
    init(webService: WebService) {
        self.webService = webService
    }
    
    func getTotalNumberOfCharacters(currentCharacters: [CurrentCharacterViewModel]) -> Int {
        var count: Int = 1
        for currentCharacter in currentCharacters {
            count = currentCharacter.characterCount
        }
        return count
    }
    
    func getTotalNumberOfPages(currentCharacters: [CurrentCharacterViewModel]) -> Int {
        var count: Int = 1
        for currentCharacter in currentCharacters {
            count = currentCharacter.pageCount
        }
        return count
    }
    
    func populateCharacters(url: String) async {
        do {
            let currentCharacter = try await webService.fetchCharacters(url: url) // fetch data from API
            if let character = currentCharacter {
                let currentCharacterViewModel = CurrentCharacterViewModel(id: UUID(), info: character.info, results: character.results) // create instance of view model with data injected
                self.currentCharacters.append(currentCharacterViewModel) // update the array of view model objects
                self.state = .successLoadingCharacters(data: currentCharacters)
            }
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
    
    struct CurrentCharacterViewModel: Identifiable {
        
        var id = UUID()
        
        let info: Info
        let results: [Result]
        
        var pageCount: Int {
            info.pages
        }
        var characterCount: Int {
            info.count
        }
        var nextURL: String {
            info.next!
        }
    }
}
