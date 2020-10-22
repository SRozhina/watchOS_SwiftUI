import SwiftUI

struct DetailView: View {
    let index: Int
    let total: Int
    let note: Note
    
    var body: some View {
        Text(note.text)
            .navigationTitle(Text("Note \(index)/\(total)"))
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(index: 1, total: 5, note: Note(id: UUID(), text: "Hello world!"))
    }
}
