//
//  RepoListView.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 21/04/22.
//

import SwiftUI

struct RepoListView: View {
    @ObservedObject var repoViewModel: RepoViewModel
    @State var repositories: [Repository] = []
    
    func fetchRepos() {
        self.repositories = self.repoViewModel.repositories
    }
    
    var body: some View {
        List(repositories, id: \.self ) { repository in
            Section(repository.name) {
                LazyVStack(alignment: .leading) {
                    RepoView(repository: repository)
                        .onAppear(perform: fetchRepos)
                }
            }
            .font(.headline)
        }
        .listStyle(.insetGrouped)
        .onChange(of: self.repoViewModel.repositories, perform: { newValue in
            self.repositories = newValue
        })
        .refreshable {
            if self.repoViewModel.repoListFull == false {
                self.fetchRepos()
            }
        }
        
        .navigationTitle("Repositories")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct RepoListView_Previews: PreviewProvider {
    static var previews: some View {
        let model = RepoViewModel()

        RepoListView(repoViewModel: model)
    }
}
