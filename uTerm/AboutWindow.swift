//
//  AboutWindow.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 12/28/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class AboutWindow: NSObject {

    var window: NSWindow!
    var infoPlistContent: NSDictionary?

    // Collect the Bundle Info.plist content
    func readResourceFile() {
        if let path = Bundle.main.path(forResource: "Info", ofType: "plist") {
            infoPlistContent = NSDictionary(contentsOfFile: path)
            //print("Dictionary: \(infoPlistContent)")
        }
    }

    // Create the window programmatically
    func createWindow() {
        window = NSWindow(contentRect: NSMakeRect(100, 100, 200, 150),
                          styleMask: .borderless,
                          backing: .buffered,
                          defer: false)
        // Showing the window
        window.makeKeyAndOrderFront(self)
        NSApp.activate(ignoringOtherApps: true)

        // Hidding the window
        window.orderOut(self)
    }
}
