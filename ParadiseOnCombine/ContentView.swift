//
//  ContentView.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 21/04/22.
//

import SwiftUI
import Combine

struct ContentView: View {
    @StateObject var repoViewModel: RepoViewModel = RepoViewModel()

    var body: some View {
            NavigationView {
                RepoListView(repoViewModel: repoViewModel)
            }
        }
        
        func passThroughSubscription() {
            let subject = PassthroughSubject<Int, Never>()

            let _ = subject
                .print()
                .sink(receiveValue: {
                    print("received by subscriber: \($0)")
                })

            subject.send(1)
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let model = RepoViewModel()
        ContentView().environmentObject(model)
    }
}
