//
//  GameView.swift
//  Tic-Tac-Toe
//
//  Created by John Kouris on 4/30/21.
//

import SwiftUI

struct GameView: View {
    @StateObject private var viewModel = GameViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()
                
                VStack {
                    Text("Difficulty Level")
                        .font(.system(.headline))
                    Picker("", selection: $viewModel.level) {
                        ForEach(DifficultyLevel.allCases, id: \.self) { value in
                            Text(value.localizedName).tag(value)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Spacer()
                
                LazyVGrid(columns: viewModel.columns, spacing: 5) {
                    ForEach(0..<9) { i in
                        ZStack {
                            GameSquareView(proxy: geometry)
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i, difficulty: viewModel.level)
                        }
                    }
                }
                
                Spacer()
            }
            .disabled(viewModel.isGameboardDisabled)
            .padding()
            .alert(item: $viewModel.alertItem, content: { alertItem in
                Alert(title: alertItem.title,
                      message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle, action: viewModel.resetGame))
            })
        }
    }
}

enum Player {
    case human, computer
}

enum DifficultyLevel: String, CaseIterable {
    case easy = "Easy", medium = "Medium", hard = "Hard"
    
    var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
}

struct Move {
    let player: Player
    let boardIndex: Int
    
    var indicator: String {
        return player == .human ? "xmark" : "circle"
    }
}

struct GameSquareView: View {
    var proxy: GeometryProxy
    
    var body: some View {
        Circle()
            .foregroundColor(.blue)
            .opacity(0.5)
            .frame(width: proxy.size.width/3 - 15,
                   height: proxy.size.width/3 - 15)
    }
}

struct PlayerIndicator: View {
    var systemImageName: String
    
    var body: some View {
        Image(systemName: systemImageName)
            .resizable()
            .frame(width: 40, height: 40)
            .foregroundColor(.white)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}


