//
//  RockPaperScissorsViewModel.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Avelardo Valdez on 10/29/20.
//

import Foundation

// this is the viewModel for the game view that is inside of ContentView.Swift
class RockPaperScissorsViewModel: ObservableObject {
    @Published var gameModel = RockPaperScissorsModel()
    
    
    // MARK: - Access to the model
    
    var level: Int {
        return gameModel.level
    }
    
    var question: String {
        return gameModel.question
    }
    
    var gameOver: Bool {
        return gameModel.gameOver
    }
    
    
    var moves: [String] {
        return gameModel.moves
    }
    
    var title: String {
        return gameModel.title
    }
    
    // MARK: - Intents
    
    func select(move: String) {
        gameModel.select(move: move)
    }
    
    func newLevel() {
        gameModel.newLevel()
    }
    
    func startNewGame() {
        gameModel.startNewGame()
    }
}
