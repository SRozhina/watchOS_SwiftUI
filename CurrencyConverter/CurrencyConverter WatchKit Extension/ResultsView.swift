import SwiftUI
import Combine

enum FetchState {
    case fetching
    case success
    case failed
}

struct ResultsView: View {
    let amount: Double
    let baseCurrency: String
    private let appID = "FILL"
    
    @State private var fetchState = FetchState.fetching
    @State private var fetchedCurrencies = [(symbol: String, rate: Double)]()
    @State private var request: AnyCancellable?
    
    var body: some View {
        Group {
            if fetchState == .success {
                List {
                    ForEach(fetchedCurrencies, id: \.symbol) { Text(rate(for: $0)) }
                }
            } else {
                Text(fetchState == .fetching ? "Fetching..." : "Fetch failed")
            }
        }
        .onAppear(perform: fetchData)
        .navigationTitle("\(Int(amount)) \(baseCurrency)")
    }
    
    private func parse(result: CurrencyResult) {
        guard !result.rates.isEmpty else {
            fetchState = .failed
            return
        }
        fetchState = .success
        let selectedCurrencies = UserDefaults.standard.array(forKey: ContentView.selectedCurrenciesKey) as? [String] ?? ContentView.defaultCurrencies
        fetchedCurrencies = result.rates.reduce(into: []) {
            if selectedCurrencies.contains($1.key) {
                $0.append(($1.key, $1.value))
            }
        }
        fetchedCurrencies.sort { $0.symbol < $1.symbol }
    }
    
    private func fetchData() {
        if let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=\(appID)&base=\(baseCurrency)") {
            request = URLSession.shared.dataTaskPublisher(for: url)
                .map(\.data)
                .decode(type: CurrencyResult.self, decoder: JSONDecoder())
                .replaceError(with: CurrencyResult(base: "", rates: [:]))
                .receive(on: DispatchQueue.main)
                .sink(receiveValue: parse)
        }
    }
    
    private func rate(for currency: (symbol: String, rate: Double)) -> String {
        let value = currency.rate * amount
        let rate = String(format: "%.2f", value)
        return "\(currency.symbol) \(rate)"
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(amount: 500, baseCurrency: "USD")
    }
}

struct CurrencyResult: Codable {
    let base: String
    let rates: [String: Double]
}
