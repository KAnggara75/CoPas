//
//  AppDelegate.swift
//  CoPas
//
//  Created by Call  Vin on 04/01/26.
//

import Cocoa

@main
final class AppDelegate: NSObject, NSApplicationDelegate {

    func applicationDidFinishLaunching(_ notification: Notification) {
        NSLog("🔥 CoPas App Launched")

        // TRUE agent mode
        NSApp.setActivationPolicy(.prohibited)
        NSApp.mainMenu = nil

        // Status bar
        MenuBarController.shared.setup()
    }
}
