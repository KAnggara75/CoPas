//
//  ClipStore.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Foundation

final class ClipStore {

    static let shared = ClipStore()

    private let maxItems = 50
    private var clips: [Clip] = []
    private let queue = DispatchQueue(
        label: "copas.clipstore.queue",
        qos: .userInitiated
    )

    private init() {}

    func add(_ clip: Clip) {
        queue.sync {
            clips.insert(clip, at: 0)

            if clips.count > maxItems {
                clips.removeLast()
            }
        }
    }

    func all() -> [Clip] {
        queue.sync {
            clips
        }
    }

    func clear() {
        queue.sync {
            clips.removeAll()
        }
    }
}
