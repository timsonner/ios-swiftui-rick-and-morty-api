//
//  ContentView.swift
//  RickAndMortyAPI
//
//  Created by Timothy Sonner on 9/29/21.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = CharacterListViewModel(webService: WebService())
    
    @State var currentPage = 1
    @State var searchText = ""
    @State var currentUrl = ""
    
    var body: some View {
        
        NavigationView {
            switch viewModel.state {
            case .success(let data):
                VStack {
                    Text("Number of characters: \(viewModel.getCharacterCount(currentCharacters: data))")
                    Text("Number of pages: \(viewModel.getCharacterPageCount(currentCharacters: data))")
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
                                        RowView(result: result, index: index!)
                                            .task {
                                                if result == response.results.last
                                 // fix if condition to detect if next page is JSON Null
//                                                    && !response.nextURL.isEmpty
//                                                    && currentPage < response.results.count
                                                {
                                                    currentPage += 1
                                                    
                                                    await viewModel.populateCharacters(url: response.nextURL)
                                                }
                                            }
                                        if index == 19 {
                                            Text("End of page")
                                                .fontWeight(.semibold)
                                                .padding()
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
                            viewModel.currentCharacters.removeAll()
                currentUrl = viewModel.rickAndMortyURL + searchText
                Task {
                    await
                    viewModel.populateCharacters(url: viewModel.rickAndMortyURL + searchText)
                }
            }
        }
        .refreshable {
            searchText = ""
            currentPage = 1
            viewModel.currentCharacters.removeAll()
            await
            viewModel.populateCharacters(url: viewModel.rickAndMortyURL)
        }
        .alert("Error",
               isPresented: $viewModel.hasError,
               presenting: viewModel.state) { errorDetails in
            Button("Retry") {
                Task {
                    await viewModel.populateCharacters(url: currentUrl)
                }
            }
        } message: { errorMessageDetail in
            if case let .failed(error) = errorMessageDetail {
                Text(" \(error.localizedDescription)")
            }
        } // MARK: - End of Error Alert
        
        .task {
            // This is the first call made to the network service. The switch statement will remain in default case if this .task is ommitted.
            currentPage = 1
            await
            viewModel.populateCharacters(url: viewModel.rickAndMortyURL)
        }
    }  // MARK: - End of body
}  // MARK: - End of ContentView

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


