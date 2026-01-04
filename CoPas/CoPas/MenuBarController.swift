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
        // Pastikan tidak double-init
        if statusItem != nil { return }

        let item = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength
        )

        guard let button = item.button else {
            return
        }

        // Icon SF Symbols (macOS 11+)
        let image = NSImage(
            systemSymbolName: "doc.on.clipboard",
            accessibilityDescription: "CoPas"
        )
        image?.isTemplate = true
        button.image = image
        button.toolTip = "CoPas Clipboard Manager"

        item.menu = buildMenu()
        self.statusItem = item
    }

    private func buildMenu() -> NSMenu {
        let menu = NSMenu()

        // Title (disabled)
        let titleItem = NSMenuItem(
            title: "CoPas",
            action: nil,
            keyEquivalent: ""
        )
        titleItem.isEnabled = false
        menu.addItem(titleItem)

        menu.addItem(.separator())

        // Preferences (dummy dulu)
        menu.addItem(
            NSMenuItem(
                title: "Preferences…",
                action: #selector(openPreferences),
                keyEquivalent: ","
            )
        )

        menu.addItem(.separator())

        // Quit
        menu.addItem(
            NSMenuItem(
                title: "Quit CoPas",
                action: #selector(quit),
                keyEquivalent: "q"
            )
        )

        return menu
    }

    // MARK: - Actions

    @objc private func openPreferences() {
        // Nanti kita isi
        NSLog("Preferences clicked")
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }
}
