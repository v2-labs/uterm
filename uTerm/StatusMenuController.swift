//
//  StatusMenuController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 29/10/16.
//  Copyright © 2016 v2-lab. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {

    @IBOutlet weak var statusMenu: NSMenu!
    private var preferences: PreferencesController!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        statusItem.menu = statusMenu
        if let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon")) {
            icon.isTemplate = true
            statusItem.image = icon
        }
    }

    @IBAction func openPreferences(_ sender: NSMenuItem) {
        if preferences == nil {
            preferences = PreferencesController()
        }
        //NSLog("Showing %@", preferences)
        preferences.showWindow(self)
        // Make sure to have it pushed to front
        NSApp.activate(ignoringOtherApps: true)
        // If in another space, bring it to you
        preferences.window!.collectionBehavior = .moveToActiveSpace
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApp.terminate(self)
        //NSApplication.shared.terminate(self)
    }
}
