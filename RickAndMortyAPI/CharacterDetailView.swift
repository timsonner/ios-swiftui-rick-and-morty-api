////
////  CharacterDetailView.swift
////  CharacterDetailView
////
////  Created by Timothy Sonner on 10/23/21.
////
//
//import SwiftUI
//
//struct CharacterDetailView: View {
//    
//    let character: CharacterListViewModel.CurrentCharacterViewModel
//    var body: some View {
//        VStack {
//        HStack {
//            AsyncImageView(image: character.image)
//            SideInfo(character: character)
//        }
//        BottomInfo(character: character)
//            Spacer()
//    }
//        .padding(.top, 18)
//                .padding(.horizontal, 20)
//                .navigationBarTitle(character.name)
//    }
//}
//
//struct BottomInfo: View {
//    
//    let character: CharacterListViewModel.CurrentCharacterViewModel
//
//    var body: some View {
//        VStack (alignment: .leading, spacing: 16.0) {
//            VStack(alignment: .leading) {
//                Text("Last known location:")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                Text(character.name)
//                    .font(.headline)
//            }
//            VStack(alignment: .leading) {
//                Text("First seen in:")
//                    .font(.caption)
//                    .foregroundColor(.secondary)
//                Text(character.name)
//                    .font(.headline)
//            }
//            Divider()
//            Text("lengthy text goes here")
//                .font(.body)
//        }
//    }
//}
//
//struct SideInfo: View {
//  
//    let character: CharacterListViewModel.CurrentCharacterViewModel
//    
//    var body: some View {
//        VStack (alignment: .leading, spacing: 8.0) {
//            HStack (alignment: .top) {
//                VStack (alignment: .leading, spacing: 8.0) {
//                    Text("movie.year" + " , " + "movie.country")
//                    Text("movie.genre")
//                    Text("movie.runtime")
//                    Text("movie.awards")
//                        .font(.callout)
//                        .foregroundColor(.secondary)
//                }
//                .font(.callout)
//                .foregroundColor(.secondary)
//                .padding(.top, 6)
//                Spacer()
////                Button(action: { self.movie.isFavorite.toggle() }) {
////                    Heart(isFilled: movie.isFavorite)
////                        .font(.title)
//                }
//            }
//            
//        }
//    }
//
//
//
