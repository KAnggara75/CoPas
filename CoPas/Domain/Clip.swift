//
//  Clip.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Cocoa

enum ClipContent {
    case text(String)
    case image(NSImage)
}

final class Clip: Identifiable {

    let id: UUID
    let createdAt: Date
    let content: ClipContent

    init(content: ClipContent) {
        self.id = UUID()
        self.createdAt = Date()
        self.content = content
    }
}
