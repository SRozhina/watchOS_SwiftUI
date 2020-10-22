import SwiftUI

struct InfoView: View {
    var body: some View {
        VStack {
            Text("Soifa")
                .padding()
            Text("iOS Developer")
                .padding()
            Image(systemName: "desktopcomputer")
                .padding()
        }
        .navigationTitle("Credentials")
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}
