//
//  AmountsView.swift
//  CurrencyConverter WatchKit Extension
//
//  Created by Софья Рожина on 06.11.2020.
//

import SwiftUI

struct AmountsView: View {
    private let defaultAmounts: [Double] = [1, 5, 10, 25, 50, 100, 250, 500, 1000]
    private let baseCurrency = UserDefaults.standard.string(forKey: ContentView.selectedCurrencyKey) ?? "USD"
    @State private var selectedAmount = 100.0
    
    var body: some View {
        VStack {
            Picker("Select an amount", selection: $selectedAmount) {
                ForEach(defaultAmounts, id: \.self) { Text(String(Int($0))) }
            }
            .font(.body)
            .labelsHidden()
            
            NavigationLink(
                destination: ResultsView(amount: selectedAmount, baseCurrency: baseCurrency),
                label: { Text("Go") }
            )
        }
    }
}

struct AmountsView_Previews: PreviewProvider {
    static var previews: some View {
        AmountsView()
    }
}
