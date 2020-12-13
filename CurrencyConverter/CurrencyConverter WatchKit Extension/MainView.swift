import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
            CurrenciesView()
            AmountsView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
