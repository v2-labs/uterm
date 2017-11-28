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
    private var preferences: PreferencesWindowController!
    let statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)

    override func awakeFromNib() {
        let icon = NSImage(named: NSImage.Name(rawValue: "statusIcon"))
        icon?.isTemplate = true
        statusItem.menu = statusMenu
        statusItem.image = icon
    }

    @IBAction func openPreferences(_ sender: NSMenuItem) {
        let preferencesController = PreferencesWindowController(windowNibName: NSNib.Name(rawValue: "Preferences"))
        preferencesController.showWindow(self)
        self.preferences = preferencesController
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared.terminate(self)
    }
}
