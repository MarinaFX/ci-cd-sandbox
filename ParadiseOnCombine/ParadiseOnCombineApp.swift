//
//  ParadiseOnCombineApp.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 21/04/22.
//

import SwiftUI


struct ParadiseOnCombineApp: App {
    let model = RepoViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView().environmentObject(model)
        }
    }
}
