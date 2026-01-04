//
//  Clip.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Cocoa

struct Clip: Identifiable, Equatable {

    enum Content: Equatable {
        case text(String)
        case image(Data) // simpan sebagai Data (aman untuk future persistence)
    }

    let id: UUID
    let content: Content
    let createdAt: Date

    init(content: Content) {
        self.id = UUID()
        self.content = content
        self.createdAt = Date()
    }
}
