//
//  RockPaperScissorsViewModel.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Avelardo Valdez on 10/29/20.
//

import Foundation

class RockPaperScissorsViewModel: ObservableObject {
    @Published var gameModel = RockPaperScissorsModel()
    
    
    // access to the model
    
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
    // intents
    
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
