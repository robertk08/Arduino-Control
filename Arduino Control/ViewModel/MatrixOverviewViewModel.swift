//
//  MatrixOverviewViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class MatrixOverviewViewModel: ObservableObject {
    @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
    @Published var showListView = false
    @ObservedObject var storage = MatrixStorage.shared
    
    func newSelectedMatrix(_ selectedMatrix: Matrix, index: Int) -> Matrix {
        var selectedMatrix = selectedMatrix
        selectedMatrix = storage.matrixes[index]
        selectedMatrix.index = index
        let command = ControlCommand(device: "Matrix", action: "changeAll", matrixValues: selectedMatrix.values)
        ConnectionService.sendRequest(command: command, arduinoIP: arduinoIP)
        Haptic.feedback(.selection)
        return selectedMatrix
    }
}
