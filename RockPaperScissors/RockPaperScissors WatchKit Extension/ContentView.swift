//
//  ContentView.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Софья Рожина on 22.10.2020.
//

import SwiftUI

struct ContentView: View {
    @State private var question = "rock"
    @State private var title = "Win!"

    @State private var shouldWin = true
    @State private var level = 1

    @State private var currentTime = Date()
    @State private var startTime = Date()
    @State private var gameOver = false

    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    private var time: String {
        let difference = currentTime.timeIntervalSince(startTime)
        return String(Int(difference))
    }

    @State private  var moves = ["rock", "paper", "scissors"]
    private let solutions = [
        "rock": (win: "scissors", lose: "paper"),
        "paper": (win: "rock", lose: "scissors"),
        "scissors": (win: "paper", lose: "rock"),
    ]


    var body: some View {
        VStack {
            if gameOver {
                Text("You win!")
                    .font(.largeTitle)
                Text("Your time: \(time) seconds")
                Button("Play again") {
                    startTime = Date()
                    gameOver = false
                    level = 1
                    newLevel()
                }
                .buttonStyle(BorderedButtonStyle(tint: .green))
            } else {
                Image(question)
                    .resizable()
                    .scaledToFit()
                Divider()
                    .padding(.vertical)
                HStack {
                    ForEach(moves, id: \.self) { type in
                        Button {
                            select(move: type)
                        } label: {
                            Image(type)
                                .resizable()
                                .scaledToFit()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                HStack {
                    Text("\(level)/20")
                    Spacer()
                    Text("time: \(time)")
                }
                .padding([.top, .horizontal])
            }
        }
        .navigationTitle(title)
        .onAppear(perform: newLevel)
        .onReceive(timer) {
            guard !gameOver else { return }
            currentTime = $0
        }
    }
    
    private func select(move: String) {
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

    private func newLevel() {
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
