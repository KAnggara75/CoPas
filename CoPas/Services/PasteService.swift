//
//  PasteService.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Cocoa

final class PasteService {

    static let shared = PasteService()
    private init() {}

    func pasteText(_ text: String) {
        ClipboardService.shared.ignoreNextClipboardChange()

        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(text, forType: .string)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.sendCommandV()
        }
    }


    private func sendCommandV() {
        let source = CGEventSource(stateID: .combinedSessionState)

        let keyVDown = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x09, // kVK_ANSI_V
            keyDown: true
        )
        keyVDown?.flags = .maskCommand

        let keyVUp = CGEvent(
            keyboardEventSource: source,
            virtualKey: 0x09,
            keyDown: false
        )
        keyVUp?.flags = .maskCommand

        keyVDown?.post(tap: .cghidEventTap)
        keyVUp?.post(tap: .cghidEventTap)
    }
}
