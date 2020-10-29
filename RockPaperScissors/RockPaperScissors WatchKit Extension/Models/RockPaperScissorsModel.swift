//
//  RockPaperScissorsGame.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Avelardo Valdez on 10/29/20.
//

import Foundation

// this is the apps model
struct RockPaperScissorsModel {
    
    private(set) var level = 1
    private(set) var question = "rock"
    private(set) var title = "Win!"
    private(set) var moves = ["rock", "paper", "scissors"]
    let solutions = [
        "rock": (win: "scissors", lose: "paper"),
        "paper": (win: "rock", lose: "scissors"),
        "scissors": (win: "paper", lose: "rock"),
    ]
    private(set) var shouldWin = true
    private(set) var gameOver = false
    
    
    mutating func select(move: String) {
        guard let answer = solutions[question] else {
            fatalError("Unknown question: \(question)")
        }
        
        let isCorrect = shouldWin
            ? move == answer.win
            : move == answer.lose
        
        if isCorrect {
            level += 1
        } else {
            level -= 1
            if level < 1 { level = 1 }
        }
        
        newLevel()
    }
    
    mutating func newLevel() {
        moves.shuffle()
        if level >= 21 {
            gameOver = true
            return
        }
        
        if Bool.random() {
            title = "Win!"
            shouldWin = true
        } else {
            title = "Lose!"
            shouldWin = false
        }
        question = moves.filter { $0 != question }.randomElement()!
    }
    
    mutating func startNewGame() {
        gameOver = false
        level = 1
    }
}
