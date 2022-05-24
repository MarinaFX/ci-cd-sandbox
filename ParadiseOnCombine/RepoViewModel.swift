//
//  RepoViewModel.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 21/04/22.
//

import Foundation
import Combine

class RepoViewModel: ObservableObject {
    @Published var repositories: [Repository] = []
        
    var repoSubscription: Set<AnyCancellable> = []
    private let url = URL(string: "https://api.github.com/users/MarinaFX/repos")!
    private lazy var pagedUrl = URL(string: "https://api.github.com/users/MarinaFX/repos?per_page=\(perPage)&page=\(currentPage+1)")!
    
    var repoListFull = false
    var currentPage = 0
    let perPage = 2

    init() {
        fetchRepos()
    }
    
    func fetchRepos() {
        URLSession.shared.dataTaskPublisher(for: pagedUrl)
            .tryMap { $0.data } //operators
            .decode(type: [Repository].self, decoder: JSONDecoder()) //operators
            .subscribe(on: DispatchQueue.global()) //operators
            .receive(on: DispatchQueue.main) //operators
            //caso o datataskpublisher nao consiga ser executado (ex: 404) o catch sera executado mandando o publisher com o rep atual (pode ser local para nao retornar vazio). Ao usar o catch, nao eh necessario o receiveCompletion, pois nao sera executado
            .catch { _ in Just(self.repositories) } //operators
        //underlying subscription, but transforms to publisher
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("failed subscription due to: \n\(error)")
                case .finished:
                    print("finished successfully")
                }
            }, receiveValue: { [weak self] repositories in
                print("repo count \(repositories.count)")
                self?.repositories = repositories
            })
            //jeito bonito de fazer uma atribuicao
            .store(in: &repoSubscription)
    }
}


//SEM PAGINACAO

/**
 self.repoSubscription = URLSession.shared.dataTaskPublisher(for: url)
     .tryMap { $0.data}
     .decode(type: [Repository].self, decoder: JSONDecoder())
 //nao seria melhor usar uma thread secundaria? Mas como estou fazendo a atribuicao aos repositorios quando recebo mudancas, precisa ser na principal
     .receive(on: DispatchQueue.main)
     .sink(receiveCompletion: { completion in
         switch completion {
         case .failure(let error):
             print("failed subscription due to: \n\(error)")
         case .finished:
             print("finished successfully")
         }
     }, receiveValue: { repositories in
         print("repo count \(repositories.count)")
         self.repositories = repositories
     })
 */
