//
//  AnimationListView.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct AnimationListView: View {
    @State private var isAnimationSettingsViewPresent = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(AnimationStorage.shared.animations, id: \ .id) { animation in
                    Text(animation.name)
                }
                .onDelete { indices in
                    AnimationStorage.shared.animations.remove(atOffsets: indices)
                    Haptic.feedback(.success)
                }
                .onMove { indices, newOffset in
                    AnimationStorage.shared.animations.move(fromOffsets: indices, toOffset: newOffset)
                    Haptic.feedback(.medium)
                }
            }
            .navigationTitle("Animation")
            .sheet(isPresented: $isAnimationSettingsViewPresent, content: {
                AnimationSettingsView(isNewAnimation: true, name: "", delay: 0.5, repeating: false, matrixes: [])
            })
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                        .buttonStyle(.bordered)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        isAnimationSettingsViewPresent = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .buttonStyle(.bordered)
                }
            }
        }
    }
}

#Preview {
    AnimationListView()
}
