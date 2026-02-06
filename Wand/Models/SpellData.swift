//
//  SpellData.swift
//  Wand
//
//  Created by app-kaihatsusha on 06/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation


struct SpellData: Codable, Identifiable {
    
    var id: String
    var name: String
    var description: String
    var soundFile: String?
    
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case description
    }
    
    
    
}
