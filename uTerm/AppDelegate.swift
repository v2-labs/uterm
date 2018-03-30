//
//  AppDelegate.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 27/10/16.
//  Copyright © 2016 v2-lab. All rights reserved.
//

import Cocoa
import MASShortcut

@NSApplicationMain

class AppDelegate: NSObject, NSApplicationDelegate {
    let preferenceModel = PreferencesModel.shared

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        /**
         No code was inserted here yet, because the StatusMenuController is
         automatically loaded at application startup by the main nib file.
         I'm considering to move it out it (nib), and initialize it here
         manually.
         *****
         The only code set here is the MASShortcut registry and its callback
         function, to make it work. I'm not sure if the change above won't be
         required for this.
         */
        MASShortcutMonitor.shared().register(preferenceModel.activationHotKey, withAction: {
            print("Hello world")
        })
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
