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

struct Clip: Identifiable {

    enum Content {
        case text(String)
        case image(Data) // nanti, belum dipakai
    }

    let id: UUID = UUID()
    let content: Content
    let createdAt: Date = Date()
}
