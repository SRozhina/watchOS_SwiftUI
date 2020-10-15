import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add note", text: $text)
                Button {
                    guard !text.isEmpty else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                } label: {
                    Image(systemName: "plus")
                        .padding()
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .blue))
            }
            List(notes) { note in
                Text(note.text)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
