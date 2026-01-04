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

    func add(_ content: Clip.Content) {
        let clip = Clip(content: content)
        clips.insert(clip, at: 0)
        NSLog("🧠 ClipStore add, total=%d", clips.count)
    }

    func all() -> [Clip] {
        return clips
    }

    func clear() {
        clips.removeAll()
    }


    func add(_ clip: Clip) {
        clips.insert(clip, at: 0)
    }

    var count: Int {
        clips.count
    }
}
