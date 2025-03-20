//
//  Animation.swift
//  Arduino Control
//
//  Created by Robert Krause on 19.03.25.
//

import SwiftUI

struct Animation: Identifiable, Codable, Equatable {
    var id: UUID
    var name: String
    var delay: Double
    var repeating: Bool
    var matrixes: [Matrix]
}
