//
//  MenuBarController.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Cocoa

final class MenuBarController {

    static let shared = MenuBarController()

    private var statusItem: NSStatusItem?

    private init() {}

    func setup() {
        statusItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength
        )

        statusItem?.button?.image = NSImage(
            systemSymbolName: "doc.on.clipboard",
            accessibilityDescription: "Clipboard"
        )

        refreshMenu()
    }

    // 🔥 INI YANG PENTING
    func refreshMenu() {
        let menu = NSMenu()
        let clips = ClipStore.shared.all()

        if clips.isEmpty {
            let emptyItem = NSMenuItem(title: "No history", action: nil, keyEquivalent: "")
            emptyItem.isEnabled = false
            menu.addItem(emptyItem)
        } else {
            let pages = clips.chunked(into: 10)

            for (pageIndex, pageClips) in pages.enumerated() {
                let start = pageIndex * 10 + 1
                let end = start + pageClips.count - 1

                let submenu = NSMenu()
                let parentItem = NSMenuItem(
                    title: "\(start)–\(end)",
                    action: nil,
                    keyEquivalent: ""
                )
                parentItem.submenu = submenu

                for clip in pageClips {
                    guard case .text(let text) = clip.content else { continue }

                    let title = text
                        .replacingOccurrences(of: "\n", with: " ")
                        .prefix(40)

                    let item = NSMenuItem(
                        title: String(title),
                        action: #selector(pasteClip(_:)),
                        keyEquivalent: ""
                    )
                    item.target = self
                    item.representedObject = text
                    submenu.addItem(item)
                }

                menu.addItem(parentItem)
            }
        }

        menu.addItem(.separator())
        menu.addItem(NSMenuItem(title: "Clear History", action: #selector(clearHistory), keyEquivalent: ""))
        menu.addItem(NSMenuItem(title: "Quit CoPas", action: #selector(quit), keyEquivalent: "q"))

        statusItem?.menu = menu
    }

    @objc private func clearHistory() {
        ClipStore.shared.clear()
        refreshMenu()
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }

    @objc private func pasteClip(_ sender: NSMenuItem) {
        guard let text = sender.representedObject as? String else { return }
        PasteService.shared.pasteText(text)
    }
}
