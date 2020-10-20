import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var text = ""
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add", text: $text)
                
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
                
                NavigationLink(destination: InfoView()) {
                    Image(systemName: "info.circle")
                        .padding()
                }
                .fixedSize()
                .buttonStyle(BorderedButtonStyle(tint: .blue))
            }
            List{
                ForEach(0..<notes.count, id: \.self) { i in
                    NavigationLink(destination: DetailView(index: i + 1, total: notes.count, note: notes[i])) {
                        Text(notes[i].text)
                            .lineLimit(3)
                    }
                }
                .onDelete(perform: delete)
            }
        }
        .navigationTitle("NoteDictate")
    }
}

extension ContentView {
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
