import SwiftUI

struct ContentView: View {
    @EnvironmentObject var store: NoteStore

    var body: some View {
        NavigationSplitView {
            FolderListView(folder: $store.root)
        } detail: {
            Text("Select a note")
        }
    }
}

struct FolderListView: View {
    @Binding var folder: Folder

    var body: some View {
        List {
            ForEach($folder.folders) { $sub in
                NavigationLink(sub.name) {
                    FolderListView(folder: $sub)
                }
            }
            ForEach(folder.notes) { note in
                NavigationLink(note.title) {
                    NoteView(note: note)
                }
            }
        }
        .navigationTitle(folder.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: addFolder) {
                    Label("Add Folder", systemImage: "folder.badge.plus")
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: addNote) {
                    Label("Add Note", systemImage: "square.and.pencil")
                }
            }
        }
    }

    func addFolder() {
        folder.folders.append(Folder(name: "New Folder"))
    }

    func addNote() {
        folder.notes.append(Note(title: "New Note"))
    }
}

struct NoteView: View {
    @State var note: Note

    var body: some View {
        List {
            ForEach(note.attachments) { attachment in
                AttachmentView(attachment: attachment)
            }
        }
        .navigationTitle(note.title)
    }
}

struct AttachmentView: View {
    let attachment: Attachment

    var body: some View {
        switch attachment {
        case .text(let text):
            Text(text)
        case .image(let data):
            if let uiImage = UIImage(data: data) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        case .audio(let url):
            Label(url.lastPathComponent, systemImage: "waveform")
        case .video(let url):
            Label(url.lastPathComponent, systemImage: "video")
        case .file(let url):
            Label(url.lastPathComponent, systemImage: "doc")
        case .annotatedImage(let annotated):
            if let uiImage = UIImage(data: annotated.imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
            }
        }
    }
}
