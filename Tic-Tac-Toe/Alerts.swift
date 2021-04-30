//
//  Alerts.swift
//  Tic-Tac-Toe
//
//  Created by John Kouris on 4/30/21.
//

import SwiftUI

struct AlertItem: Identifiable {
    let id = UUID()
    var title: Text
    var message: Text
    var buttonTitle: Text
}

struct AlertContext {
    static let humanWin = AlertItem(title: Text("You win"),
                                    message: Text("You are so smart. You beat the AI."),
                                    buttonTitle: Text("Yeah!"))
    static let computerWin = AlertItem(title: Text("Computer wins"),
                                       message: Text("You are so dumb. You lost to the AI."),
                                       buttonTitle: Text("Rematch"))
    static let draw = AlertItem(title: Text("Draw"),
                                message: Text("No one wins"),
                                buttonTitle: Text("Try Again"))
}
