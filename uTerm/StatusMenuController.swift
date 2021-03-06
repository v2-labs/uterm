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

    let statusItem = NSStatusBar.system().statusItem(withLength: NSVariableStatusItemLength)


    override func awakeFromNib() {
        let icon = NSImage(named: "statusIcon")
        icon?.isTemplate = true
        statusItem.menu = statusMenu
        statusItem.image = icon
        // statusItem.title = "uTerm"
    }

    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApplication.shared().terminate(self)
    }
}
