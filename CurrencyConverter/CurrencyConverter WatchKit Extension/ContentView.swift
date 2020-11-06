import SwiftUI

struct ContentView: View {
    @State private var amount = UserDefaults.standard.double(forKey: amountKey)
    @State private var selectedCurrency = UserDefaults.standard.string(forKey: selectedCurrencyKey) ?? "USD"
    @State private var amountFocused = false
    
    static let currencies = ["USD", "AUD", "CAD", "CHF", "CNY", "EUR", "GBP", "HKD", "JPY", "SGD"]
    static let defaultCurrencies = ["USD", "EUR"]
    
    static let selectedCurrenciesKey = "SelectedCurrencies"
    static let amountKey = "AmountKey"
    static let selectedCurrencyKey = "SelectedCurrency"
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                Text("\(Int(amount))")
                    .font(.system(size: 52))
                    .padding()
                    .frame(width: geo.size.width)
                    .contentShape(Rectangle())
                    .focusable { amountFocused = $0 }
                    .digitalCrownRotation($amount, from: 0, through: 1000, by: 20, sensitivity: .high, isContinuous: false, isHapticFeedbackEnabled: true)
                    .overlay(RoundedRectangle(cornerRadius: 10).strokeBorder(amountFocused ? Color.green : Color.white, lineWidth: 1))
                    .padding(.bottom)
                
                HStack {
                    Picker("Select a currency", selection: $selectedCurrency) {
                        ForEach(Self.currencies, id: \.self) { Text($0) }
                    }
                    .labelsHidden()
                    
                    NavigationLink(
                        destination: ResultsView(amount: amount, baseCurrency: selectedCurrency),
                        label: { Text("Go") }
                    )
                    .frame(width: geo.size.width * 0.4)
                }
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
