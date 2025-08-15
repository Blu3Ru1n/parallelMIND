import Foundation
import SwiftUI

struct Folder: Identifiable, Codable {
    let id: UUID
    var name: String
    var folders: [Folder]
    var notes: [Note]

    init(id: UUID = UUID(), name: String, folders: [Folder] = [], notes: [Note] = []) {
        self.id = id
        self.name = name
        self.folders = folders
        self.notes = notes
    }
}

struct Note: Identifiable, Codable {
    let id: UUID
    var title: String
    var attachments: [Attachment]

    init(id: UUID = UUID(), title: String, attachments: [Attachment] = []) {
        self.id = id
        self.title = title
        self.attachments = attachments
    }
}

enum Attachment: Identifiable, Codable {
    case text(String)
    case image(Data)
    case audio(URL)
    case video(URL)
    case file(URL)
    case annotatedImage(AnnotatedImage)

    var id: UUID {
        return UUID()
    }
}

struct AnnotatedImage: Identifiable, Codable {
    let id: UUID
    var imageData: Data
    var annotations: [Annotation]

    init(id: UUID = UUID(), image: UIImage, annotations: [Annotation] = []) {
        self.id = id
        self.imageData = image.pngData() ?? Data()
        self.annotations = annotations
    }
}

struct Annotation: Identifiable, Codable {
    let id: UUID
    var point: CGPoint
    var color: Color
    var lineWidth: CGFloat

    init(id: UUID = UUID(), point: CGPoint, color: Color = .red, lineWidth: CGFloat = 2) {
        self.id = id
        self.point = point
        self.color = color
        self.lineWidth = lineWidth
    }
}

class NoteStore: ObservableObject {
    @Published var root: Folder

    init() {
        self.root = Folder(name: "Root")
    }
}
