//
//  ListView.swift
//  ListView
//
//  Created by Timothy Sonner on 9/29/21.
//

import SwiftUI

struct ListView: View {
    
    @StateObject private var characterVM = CharacterViewModel(webService: WebService())
    
    @State var currentPage = 1
    @State var searchText = ""
    @State var currentUrl = ""
    
    
    var body: some View {
        
        NavigationView {
            switch characterVM.state {
            case .successLoadingCharacters(let data):
                VStack {
                    Text("Number of characters: \(characterVM.getTotalNumberOfCharacters(currentCharacters: data))")
                    Text("Number of pages: \(characterVM.getTotalNumberOfPages(currentCharacters: data))")
                    Text("Pages Loaded: \(currentPage)")
                    List {
                        
                        ForEach(data) {
                            arrayOfResult in
                            ForEach(arrayOfResult.results) {
                                result in
                                
                                VStack {
                                    NavigationLink(destination: DetailView(result: result)) {
                                        RowView(result: result)
                                            .task {
                                                
                                                if result == arrayOfResult.results.last && (arrayOfResult.nextURL  != nil) && (arrayOfResult.nextURL != currentUrl)
                                                {
                                                    
                                                    await characterVM.populateCharacters(url: arrayOfResult.nextURL!)
                                                    self.currentUrl = arrayOfResult.nextURL!
                                                    
                                                    self.currentPage += 1
                                                }
                                            }
                                    }
                                }
                            }
                        }
                    }
                } // MARK: - End of List
                .navigationBarTitle("Rick and Morty API")
                .listStyle(.plain)
                
            case .loading:
                ProgressView()
                
            default:
                Text("Wubba Lubba Dub-Dub")
                
            } // MARK: - End of Switch Statement
        } // MARK: - End of NavigationView
        .searchable(text: $characterVM.searchText)
        .onChange(of: characterVM.searchText) { text in
            if !text.isEmpty {
                currentUrl = characterVM.rickAndMortyURL + text
                characterVM.currentCharacters.removeAll()
                Task {
                    await
                    characterVM.populateCharacters(url: characterVM.rickAndMortyURL + text)
                }
            }
        }
        .refreshable {
            characterVM.searchText = ""
            currentPage = 1
            characterVM.currentCharacters.removeAll()
            await
            characterVM.populateCharacters(url: characterVM.rickAndMortyURL)
        }
        
        .alert("Error",
               isPresented: $characterVM.hasError,
               presenting: characterVM.state) { errorDetails in
            Button("Retry") {
                Task {
                    await characterVM.populateCharacters(url: currentUrl)
                }
            }
        } message: { errorMessage in
            if case let .failed(error) = errorMessage {
                Text(" \(error.localizedDescription)")
            }
        } // MARK: - End of Error Alert
        
        .task {
            // This is the first call made to the network service. The switch statement will remain in default case if this .task is ommitted.
            currentPage = 1
            await
            characterVM.populateCharacters(url: characterVM.rickAndMortyURL)
        }
    }  // MARK: - End of body
}  // MARK: - End of ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
            .preferredColorScheme(.light)
    }
}


