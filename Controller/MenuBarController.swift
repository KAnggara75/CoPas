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

    func setup() {
        statusItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength
        )

        statusItem?.button?.image = NSImage(
            systemSymbolName: "doc.on.clipboard",
            accessibilityDescription: nil
        )

        let menu = NSMenu()
        menu.addItem(
            NSMenuItem(
                title: "Quit CoPas",
                action: #selector(quit),
                keyEquivalent: "q"
            )
        )

        statusItem?.menu = menu
    }

    @objc private func quit() {
        NSApp.terminate(nil)
    }
}
