import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
            CurrenciesView()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
