//
//  DetailView.swift
//  Wand
//
//  Created by app-kaihatsusha on 06/02/2026.
//  Copyright © 2026 app-kaihatsusha. All rights reserved.
//

import SwiftUI
import AVFAudio

struct DetailView: View {
    
    @State var spell: SpellData
    @State private var audioPlayer: AVAudioPlayer!
    @State var offset: CGSize = .zero
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            
            
            Text("Spell Name:")
                .font(.custom("Avenir Next Condensed", size: 30))
                .foregroundStyle(.potterPurple).bold()
            
            TextField("", text: $spell.name)
                .font(.custom("Avenir Next Condensed", size: 24))
                .lineLimit(1)
                .minimumScaleFactor(0.5)
            
                

            Text("Description:")
                .font(.custom("Avenir Next Condensed", size: 30))
                .foregroundStyle(.potterPurple).bold()
            
            TextField("", text: $spell.description, axis: .vertical)
                .font(.custom("Avenir Next Condensed", size: 24))
            
            Spacer()
            
            HStack {
                Spacer()
                Image("magic-wand")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .offset(offset)
                    .gesture(
                        DragGesture()
                            .onChanged{ value in
                                withAnimation(.spring()) {
                                    offset = value.translation
                                    
                                }
                            }
                            .onEnded{ value in
                                withAnimation(.spring()) {
                                    offset = .zero
                                    playSound(soundName: spell.soundFile ?? "")
                                }
                            }
                    )
                Spacer()
            }

            Spacer()
        }
        
        .navigationBarTitleDisplayMode(.inline)
        .padding(.top)
        .padding(.horizontal)
    }
    
    
    func playSound(soundName: String) {
        
        if audioPlayer != nil && audioPlayer.isPlaying {
            audioPlayer.stop()
        }
        guard let soundFile = NSDataAsset(name: soundName) else {
            print("😡 Could not read file named \(soundName)")
            return
        }
        
        do {
            audioPlayer = try AVAudioPlayer(data: soundFile.data)
            audioPlayer.play()
        } catch {
            print("😡 ERROR: \(error.localizedDescription) creating audioPlayer.")
        }
    }
}

#Preview {
    DetailView(spell: SpellData(id: "1", name: "Magic", description: "More Magic"))
}
