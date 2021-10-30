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
    @State var index = 0
    
    var body: some View {
        
        NavigationView {
            switch characterVM.state {
            case .successLoadingCharacters(let data):
                VStack {
                    Text("Number of characters: \(characterVM.getTotalNumberOfCharacters(currentCharacters: data))")
                    Text("Number of pages: \(characterVM.getTotalNumberOfPages(currentCharacters: data))")
                    Text("Pages Loaded: \(currentPage)")
                    //                    Text(data.response.results.last)
                    List {
                        // EditButton()
                        ForEach(data) {
                            response in
                            // response.pageCount
                            
                            ForEach(response.results) {
                                result in
                                
                                let index = response.results.firstIndex(where: { $0.id == result.id})
                                                                    
                                    VStack {
                                        NavigationLink(destination: DetailView(result: result)) {
                                        RowView(result: result, index: index!)
                                            .task {
                                                if result == response.results.last
                                 // fix if condition to detect if next page is JSON Null
//                                                    && !response.nextURL.isEmpty
//                                                    && currentPage < response.results.count
                                                {
                                                    currentPage += 1
                                                    
                                                    await characterVM.populateCharacters(url: response.nextURL)
                                                }
                                            }
                                        if index == 19 {
                                            Text("End of page")
                                                .fontWeight(.semibold)
                                                .padding()
                                        } // MARK: - End of RowView
                                    }
                                 }
                            }
                        }
                    }
                    //                    .onMove { (source, destination) in
                    //                                               viewModel.moveItemInDataArray(source: source, toOffset: destination)
                    //                                           }
                    //                                           .onDelete { offsets in
                    //                                               viewModel.removeItemFromDataArray(offsets: offsets)
                    //                                           }
                    
                    
                } // MARK: - End of List
                .navigationBarTitle("Rick and Morty API")
                .listStyle(.plain)
                
            case .loading:
                ProgressView()
                
            default:
                Text("Wubba Lubba Dub-Dub")
            } // MARK: - End of Switch Statement
        } // MARK: - End of NavigationView
        .searchable(text: $searchText)
        .onChange(of: searchText) { text in
            if !text.isEmpty {
                searchText = text
                            characterVM.currentCharacters.removeAll()
                currentUrl = characterVM.rickAndMortyURL + searchText
                Task {
                    await
                    characterVM.populateCharacters(url: characterVM.rickAndMortyURL + searchText)
                }
            }
        }
        .refreshable {
            searchText = ""
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
            .preferredColorScheme(.dark)
    }
}


