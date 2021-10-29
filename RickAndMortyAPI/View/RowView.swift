//
//  RowView.swift
//  RowView
//
//  Created by Timothy Sonner on 10/14/21.
//

import SwiftUI

struct RowView: View {
    var result: Result
    @State var index: Int
    
    var body: some View {

        HStack(spacing: 24) {
           //
            Text("\(index + 1)")
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

