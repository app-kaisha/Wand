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
    
    
    let soundNames = [
        "Accio_Dittany",
        "Accio_Firebolt",
        "Accio_Locket",
        "Aguamenti",
        "Alohomora",
        "Arania_Exumai",
        "Arresto_Momentum",
        "Ascendio",
        "Confundus",
        "Crucio",
        "Cuteness_Charm",
        "Diffindo",
        "Everte_Statum",
        "Expecto_Patronum",
        "Expulso",
        "Fera_Verto",
        "Finita",
        "Finite_Incantatem",
        "GirlsAreGonnaKillMe",
        "Happy_Christmas",
        "Harry_Theme",
        "Homenum_Revelio",
        "Immobilus",
        "Incendio",
        "Lumos_Maxima",
        "Lumos_Solem_Hermione",
        "Maya_Explosius",
        "Morsmorde",
        "Muffliato",
        "Obliviate",
        "Oculus_Reparo",
        "Oppugno",
        "Peskipiksi_Pesternomi",
        "Petrificus_Totalus",
        "Protego_Totalum",
        "Reducto",
        "Repello_Muggletum",
        "Riddikulus",
        "Salvio_Hexia",
        "Snape_Expelliarmus",
        "Vipera_Evanesca",
        "Volate_Ascendere",
        "Whirlygirl",
        "Wingardium_Leviosa",
        "episkey",
        "expelliarmus",
        "explosion",
        "sectumsempra",
        "stupefy"
    ]
    
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
                self.spellArray.indices.forEach { self.spellArray[$0].soundFile = findSoundName(apiSpell: self.spellArray[$0].name.lowercased())}
            }
        } catch {
            print("😡 ERROR: Could not get data from \(urlString)")
        }
    }
    
    private func findSoundName(apiSpell: String) -> String {
            
        if let firstIndex = soundNames.firstIndex(where: { $0.replacingOccurrences(of: "_", with: " ").lowercased() == apiSpell.lowercased() }) {
            print("\(apiSpell) soundName: \(soundNames[firstIndex])")
            return soundNames[firstIndex]
        } else {
            return soundNames.randomElement() ?? ""
        }
    }
    
}
