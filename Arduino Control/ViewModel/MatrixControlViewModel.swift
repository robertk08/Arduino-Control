//
//  MatrixControlViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class MatrixControlViewModel: ObservableObject {
    @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
    @Published var sendCommandTimer: Timer? = nil
    @Published var selectedMatrix = MatrixStorage.shared.matrixes.first!
    
    func updateSelectedMatrix() {
        if sendCommandTimer == nil {
            sendCommandTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { _ in
                let command = ControlCommand(device: "Matrix", action: "changeAll", matrixValues: self.selectedMatrix.values)
                ConnectionService.sendRequest(command: command, arduinoIP: self.arduinoIP)
                self.sendCommandTimer = nil
            }
        }
    }
}
