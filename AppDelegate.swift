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
        NSApp.setActivationPolicy(.prohibited)
        print("🔥 CoPas started")
//        MenuBarController.shared.setup()
    }
}

