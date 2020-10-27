import SwiftUI

struct ContentView: View {
    @State private var notes: [Note] = []
    @State private var text = ""
    
    @AppStorage("lineCount") var lineCount = 1
    
    var body: some View {
        VStack {
            HStack {
                TextField("Add", text: $text)
                
                Button {
                    guard !text.isEmpty else { return }
                    let note = Note(id: UUID(), text: text)
                    notes.append(note)
                    text = ""
                    save()
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
                            .lineLimit(lineCount)
                    }
                }
                .onDelete(perform: delete)
                
                Button("Lines: \(lineCount)") {
                    lineCount += 1
                    
                    if lineCount >= 4 { lineCount = 1 }
                }
            }
        }
        .navigationTitle("NoteDictate")
        .onAppear(perform: load)
    }
}

extension ContentView {
    func delete(offsets: IndexSet) {
        withAnimation {
            notes.remove(atOffsets: offsets)
            save()
        }
    }
    
    func getDocumentDirectory() -> URL {
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return path[0]
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(notes)
            let url = getDocumentDirectory().appendingPathComponent("notes")
            try data.write(to: url)
        } catch {
            print("Failed to write data")
        }
    }
    
    func load() {
        DispatchQueue.main.async {
            do {
                let url = getDocumentDirectory().appendingPathComponent("notes")
                let data = try Data(contentsOf: url)
                notes = try JSONDecoder().decode([Note].self, from: data)
            } catch { /* Do nothing */ }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
