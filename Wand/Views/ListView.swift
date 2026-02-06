//
//  ListView.swift
//  Wand
//
//  Created by app-kaihatsusha on 06/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

// https://hp-api.onrender.com/api/spells

import SwiftUI

struct ListView: View {
    
    @State private var spells = ["Accio Dittany", "Accio Firebolt", "Accio Locket"]
    @State private var spellVM = Spells()
    
    var body: some View {
        NavigationStack {
            List(spells, id: \.self) { spell in
                Text(spell)
                    .font(.custom("Avenir Next Condensed", size: 24))
            }
            .listStyle(.plain)
            .navigationTitle("Olivander's Wand")
        }
        .task {
            await spellVM.getData()
        }
    }
}

#Preview {
    ListView()
}
