//
//  RowView.swift
//  RowView
//
//  Created by Timothy Sonner on 10/14/21.
//

import SwiftUI

struct RowView: View {
    
    @StateObject private var characterVM = CharacterViewModel(webService: WebService())
    
    var result: Result
    
    var body: some View {
        HStack(spacing: 24) {
      
            AsyncImageView(image: result.image)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(result.name)
                    .font(.headline)
                
                Text("Species: \(result.species)")
                    .font(.subheadline)
                
                Group {
                    Text("Gender: \(result.gender.rawValue)")
                    
                    Text("Origin: \(result.origin.name)")
                }
                .font(.caption)
                .foregroundColor(.secondary)
            }
        }
    }
}

