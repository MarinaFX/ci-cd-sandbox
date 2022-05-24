//
//  Repository.swift
//  ParadiseOnCombine
//
//  Created by Marina De Pazzi on 21/04/22.
//

import Foundation

struct Repository: Hashable, Decodable, Encodable {
    let id: Int
    let name: String
    let `private`: Bool
    let description: String?
    
}
