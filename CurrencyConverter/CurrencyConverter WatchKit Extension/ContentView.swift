//
//  ContentView.swift
//  CurrencyConverter WatchKit Extension
//
//  Created by Софья Рожина on 29.10.2020.
//

import SwiftUI


struct ContentView: View {
    @State private var amount = 500.0
    @State private var selectedCurrency = "USD"
    
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD"]
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Text("\(Int(amount))")
                    .font(.system(size: 52))
                
                Slider(value: $amount, in: 0...1000, step: 20)
                    .accentColor(.green)
                    .frame(height: geo.size.height / 3)
                
                HStack {
                    Picker("Select a currency", selection: $selectedCurrency) {
                        ForEach(Self.currencies, id: \.self) { Text($0) }
                    }
                    .labelsHidden()
                    
                    NavigationLink(
                        destination: Text("Detail view"),
                        label: { Text("Go") }
                    )
                    .frame(width: geo.size.width * 0.4)
                }
                .frame(height: geo.size.height / 3)
            }
            .navigationTitle("WatchFX")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
