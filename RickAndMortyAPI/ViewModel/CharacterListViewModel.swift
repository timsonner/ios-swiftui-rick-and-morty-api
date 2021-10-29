//
//  CharacterViewModel.swift
//  CharacterViewModel
//
//  Created by Timothy Sonner on 9/30/21.
//

import Foundation
import SwiftUI

@MainActor
class CharacterListViewModel: ObservableObject {
    
    enum State {
        case initialState
        case loading
        case success(data: [CurrentCharacterViewModel])
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
    
    func getCharacterCount(currentCharacters: [CurrentCharacterViewModel]) -> Int {
        var count: Int = 1 // maybe change to 0
        for currentCharacter in currentCharacters {
            count = currentCharacter.characterCount
        }
        return count
    }
    
    func getCharacterPageCount(currentCharacters: [CurrentCharacterViewModel]) -> Int {
        var count: Int = 1 // maybe change to 0
        for currentCharacter in currentCharacters {
            count = currentCharacter.pageCount
            
        }
        return count
    }
    
    
    func populateCharacters(url: String) async {
        do {
            let currentCharacter = try await webService.NetworkRequest(url: url) // fetch data from API
            if let fooCharacter = currentCharacter {
                //                    for character in fooCharacter.results {
                let currentCharacterViewModel = CurrentCharacterViewModel(id: UUID(), info: fooCharacter.info, results: fooCharacter.results) // create instance of view model with data injected
                self.currentCharacters.append(currentCharacterViewModel) // update the array of view model objects
                //                    }
                self.state = .success(data: currentCharacters)
            }
        } catch {
            self.state = .failed(error: error)
            self.hasError = true
        }
    }
    //info: charactercurrentCharacter.info, currentCharacter: currentCharacter.results
    
    
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
    //        let id: Int
    //        let name: String
    //        let status: Status
    //        let species: String
    //        let type: String
    //        let gender: Gender
    //        let origin, location: Location
    //        let image: String
    //        let episode: [String]
    //        let url: String
    //        let created: String
    
    
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
