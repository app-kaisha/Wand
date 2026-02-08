//
//  ListView.swift
//  Wand
//
//  Created by app-kaihatsusha on 06/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

// https://hp-api.onrender.com/api/spells
// https://api.potterdb.com/v1/spells

import SwiftUI

struct ListView: View {
    
    @State private var spellVM = Spells()
    
    var body: some View {
        NavigationStack {
            List(spellVM.spellArray) { spell in
                NavigationLink {
                    DetailView(spell: spell)
                } label: {
                    Text(spell.name)
                        .font(.custom("Avenir Next Condensed", size: 24))
                }
            }
            .listStyle(.plain)
            .navigationTitle("Olivander's Wand")
            .navigationBarColour(.potterPurple)
        }
        .task {
            await spellVM.getData()
            
        }
    }
}

#Preview {
    ListView()
}
