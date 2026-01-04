//
//  ClipboardService.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Cocoa

final class ClipboardService {

    static let shared = ClipboardService()

    private let pasteboard = NSPasteboard.general
    private var lastChangeCount: Int
    private var ignoreNextChange = false

    private init() {
        lastChangeCount = pasteboard.changeCount
        NSLog("📋 ClipboardService init, count=%d", lastChangeCount)
    }

    func start() {
        Timer.scheduledTimer(
            timeInterval: 0.3,
            target: self,
            selector: #selector(checkClipboard),
            userInfo: nil,
            repeats: true
        )
    }

    /// Dipanggil sebelum paste internal
    func ignoreNextClipboardChange() {
        ignoreNextChange = true
        NSLog("🚫 Will ignore next clipboard change")
    }

    @objc private func checkClipboard() {
        let currentCount = pasteboard.changeCount
        guard currentCount != lastChangeCount else { return }

        lastChangeCount = currentCount

        if ignoreNextChange {
            NSLog("🚫 Ignored internal paste")
            ignoreNextChange = false
            return
        }

        guard let text = pasteboard.string(forType: .string),
              !text.isEmpty else {
            return
        }

        ClipStore.shared.add(
            Clip(content: .text(text))
        )

        NSLog("📋 Clipboard captured, total=%d", ClipStore.shared.count)

        DispatchQueue.main.async {
            MenuBarController.shared.refreshMenu()
        }
    }
}
