//
//  RockPaperScissorsApp.swift
//  RockPaperScissors WatchKit Extension
//
//  Created by Софья Рожина on 22.10.2020.
//

import SwiftUI

@main
struct RockPaperScissorsApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView(gameViewModel: RockPaperScissorsViewModel())
            }
        }
    }
}
