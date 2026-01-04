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

    private init() {
        self.lastChangeCount = pasteboard.changeCount
    }

    func start() {
        Timer.scheduledTimer(
            timeInterval: 0.3,
            target: self,
            selector: #selector(checkPasteboard),
            userInfo: nil,
            repeats: true
        )
    }

    @objc private func checkPasteboard() {
        guard pasteboard.changeCount != lastChangeCount else {
            return
        }

        lastChangeCount = pasteboard.changeCount
        handlePasteboardChange()
    }

    private func handlePasteboardChange() {
        if let string = pasteboard.string(forType: .string) {
            let clip = Clip(content: .text(string))
            ClipStore.shared.add(clip)

            NSLog("📋 Clip added (text)")
            return
        }

        if let image = pasteboard.readObjects(
            forClasses: [NSImage.self],
            options: nil
        )?.first as? NSImage {
            let clip = Clip(content: .image(image))
            ClipStore.shared.add(clip)

            NSLog("📋 Clip added (image)")
            return
        }
    }

}
