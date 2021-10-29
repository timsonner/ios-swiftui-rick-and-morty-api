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
            SideInfo(result: result)
        }
        BottomInfo(result: result)
            Spacer()
    }
        .padding(.top, 18)
                .padding(.horizontal, 20)
                .navigationBarTitle(result.name)
    }
}

struct BottomInfo: View {
    
    var result: Result

    var body: some View {
        VStack (alignment: .leading, spacing: 16.0) {
            VStack(alignment: .leading) {
                Text("Last known location:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(result.name)
                    .font(.headline)
            }
            VStack(alignment: .leading) {
                Text("First seen in:")
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text(result.name)
                    .font(.headline)
            }
            Divider()
            Text("lengthy text goes here")
                .font(.body)
        }
        .padding()
    }
}

struct SideInfo: View {
  
    let result: Result
    
    var body: some View {
        VStack (alignment: .leading, spacing: 8.0) {
            HStack (alignment: .top) {
                VStack (alignment: .leading, spacing: 8.0) {
                    Text(result.name + " , " + result.species)
                    Text(result.gender.rawValue)
                    Text(result.status.rawValue)
                    Text(result.name)
                        .font(.callout)
                        .foregroundColor(.secondary)
                }
                .font(.callout)
                .foregroundColor(.secondary)
                .padding()
                Spacer()

                }
            }
            
        }
    }



