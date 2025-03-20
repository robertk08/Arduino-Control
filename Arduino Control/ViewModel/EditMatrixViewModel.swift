//
//  EditMatrixViewModel.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import Foundation
import SwiftUI

class EditMatrixViewModel: ObservableObject {
    @AppStorage("arduinoIP") var arduinoIP = "192.168.4.1"
    @Published var isOn = true
    
    func updateLedState(selectedMatrix: Matrix, at location: CGPoint, in size: CGSize, columns: Int, rows: Int) -> Matrix {
        var selectedMatrix = selectedMatrix
        let cellSize = (size.width - CGFloat(columns) * 10) / CGFloat(columns) - 10 / CGFloat(columns) + 10
        let x = Int((location.x - 10) / cellSize)
        let y = Int(location.y / cellSize)
        
        if (0..<columns).contains(x), (0..<rows).contains(y) {
            if selectedMatrix.values[y][x] != self.isOn {
                Haptic.feedback(.selection)
                let command = ControlCommand(device: "Matrix", action: "changeSingle", position: [x, y, self.isOn ? 1 : 0])
                //ConnectionService.sendRequest(command: command, arduinoIP: self.arduinoIP)
            }
            selectedMatrix.values[y][x] = self.isOn
        }
        return selectedMatrix
    }
}
