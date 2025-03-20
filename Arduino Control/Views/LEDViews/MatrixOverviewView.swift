//
//  MatrixOverviewView.swift
//  Arduino Control
//
//  Created by Robert Krause on 18.03.25.
//

import SwiftUI

struct MatrixOverviewView: View {
    @StateObject private var viewModel = MatrixOverviewViewModel()
    @Binding var selectedMatrix: Matrix
    @ObservedObject var storage = MatrixStorage.shared
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(storage.matrixes.indices, id: \.self) { index in
                    GroupBox {
                        MatrixView(index: index)
                            .frame(width: 150, height: 135)
                    }
                    .padding(10)
                    .contextMenu {
                        Button("Delete") {
                            Haptic.feedback(.success)
                            storage.matrixes.remove(at: index)
                        }
                    }
                    .onTapGesture {
                        Haptic.feedback(.soft)
                        selectedMatrix = viewModel.newSelectedMatrix(selectedMatrix, index: index)
                    }
                }
                GroupBox {
                    Button(action: {
                        viewModel.showListView = true
                    }, label: {
                        VStack {
                            Image(systemName: "ellipsis")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80)
                        }
                        .frame(width: 120, height: 120)
                    })
                    .tint(.accentColor)
                    .buttonStyle(.bordered)
                    .frame(width: 150, height: 135)
                }
                .padding(10)
                
            }
            .sheet(isPresented: $viewModel.showListView) {
                MatrixListView()
            }
        }
    }
}

#Preview {
    MatrixOverviewView(selectedMatrix: .constant(MatrixStorage.shared.matrixes.first!))
}
