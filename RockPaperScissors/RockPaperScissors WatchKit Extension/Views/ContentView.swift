//
//  ContentView.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Софья Рожина on 22.10.2020.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var gameViewModel: RockPaperScissorsViewModel

    @State private var currentTime = Date()
    @State private var startTime = Date()
    
    private let timer = Timer.publish(every: 1, on: .main, in: .default).autoconnect()
    private var time: String {
        let difference = currentTime.timeIntervalSince(startTime)
        return String(Int(difference))
    }

    var body: some View {
        VStack {
            if gameViewModel.gameOver {
                Text("You win!")
                    .font(.largeTitle)
                Text("Your time: \(time) seconds")
                Button("Play again") {
                    startTime = Date()
                    gameViewModel.startNewGame()
                    gameViewModel.newLevel()
                }
                .buttonStyle(BorderedButtonStyle(tint: .green))
            } else {
                Image(gameViewModel.question)
                    .resizable()
                    .scaledToFit()
                Divider()
                    .padding(.vertical)
                HStack {
                    ForEach(gameViewModel.moves, id: \.self) { type in
                        Button {
                            gameViewModel.select(move: type)
                        } label: {
                            Image(type)
                                .resizable()
                                .scaledToFit()
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                HStack {
                    Text("\(gameViewModel.level)/20")
                    Spacer()
                    Text("time: \(time)")
                }
                .padding([.top, .horizontal])
            }
        }
        .navigationTitle(gameViewModel.title)
        .onAppear(perform: gameViewModel.newLevel)
        .onReceive(timer) {
            guard !gameViewModel.gameOver else { return }
            currentTime = $0
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gameViewModel: RockPaperScissorsViewModel())
    }
}
