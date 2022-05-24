//
//  RepoView.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 21/04/22.
//

import SwiftUI

struct RepoView: View {
    var repository: Repository
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Repo ID: \(repository.id)")
                .font(.body)
            
            Divider()
            
            Text(repository.description?.isEmpty ?? "".isEmpty ? "No Description" : "Repo Description: \(repository.description ?? "")")
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.leading)
                .font(.body)
            
            Divider()
            
            Text("Private: \(String(repository.private ))")
                .font(.callout)
                .foregroundColor(.gray)
        }
    }
}
