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
    
    
    
    private let moves = ["rock", "paper", "scissors"]
    
    var body: some View {
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {
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
            }
        }
        //.background(Color.white)
        .navigationTitle(title)
    }
    
    private func select(move: String) {
    
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
