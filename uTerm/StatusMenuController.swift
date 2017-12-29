//
//  StatusMenuController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 29/10/16.
//  Copyright © 2016 v2-lab. All rights reserved.
//

import Cocoa

class StatusMenuController: NSObject {
    //
    private var about: AboutWindow!
    private var preferences: PreferencesController!
    let appStatusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
    //
    @IBOutlet weak var statusMenu: NSMenu!

    // MARK: - StatusMenuController delegate methods

    /**
     */
    override func awakeFromNib() {
        appStatusItem.menu = statusMenu
        if let menuIcon = NSImage(named: NSImage.Name(rawValue: "statusIcon")) {
            menuIcon.isTemplate = true
            appStatusItem.image = menuIcon
        }
        else {
            appStatusItem.title = "uTerm"
        }
    }

    // MARK: - StatusMenuController action methods

    /**
     */
    @IBAction func openAbout(_ sender: NSMenuItem) {
        //
    }
    /**
     */
    @IBAction func openPreferences(_ sender: NSMenuItem) {
        if preferences == nil {
            preferences = PreferencesController()
        }
        preferences.showWindow(self)
        // Make sure to have it pushed to front
        NSApp.activate(ignoringOtherApps: true)
        // If in another space, bring it to you
        preferences.window!.collectionBehavior = .moveToActiveSpace
    }

    /**
     */
    @IBAction func quitClicked(_ sender: NSMenuItem) {
        NSApp.terminate(self)
    }
}
