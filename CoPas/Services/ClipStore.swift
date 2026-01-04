//
//  ClipStore.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Foundation

final class ClipStore {

    static let shared = ClipStore()
    private init() {}

    private var clips: [Clip] = []
    private let maxItems = 300

    var count: Int {
        clips.count
    }

    func add(_ clip: Clip) {
        if let last = clips.first, last == clip {
            return
        }

        clips.insert(clip, at: 0)

        if clips.count > maxItems {
            clips.removeLast(clips.count - maxItems)
        }

        NSLog("🧠 ClipStore add, total=%d", clips.count)
    }

    func all() -> [Clip] {
        clips
    }

    func clear() {
        clips.removeAll()
        NSLog("🧹 ClipStore cleared")
    }
}
