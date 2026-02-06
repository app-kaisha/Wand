//
//  Spells.swift
//  Wand
//
//  Created by app-kaihatsusha on 06/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import Foundation

@Observable
class Spells {
    
    var spellArray: [SpellData] = []
    var urlString = "https://hp-api.onrender.com/api/spells"
    
    func getData() async {
        
        print("🕸️ We are accessing the url \(urlString)")
        // Create URL
        guard let url = URL(string: urlString) else {
            print("😡 ERROR: Could not create a URL from \(urlString)")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            // decode JSON into data structure
            guard let spells = try? JSONDecoder().decode([SpellData].self, from: data) else {
                
                print("😡 JSON ERROR: Could not decode returned JSON data")
                return
            }
            
            // Confirm data was decoded:
            print("😎 JSON returned! Spell count: \(spells.count)")
            Task { @MainActor in
                self.spellArray = spells
            }
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    
    
}
