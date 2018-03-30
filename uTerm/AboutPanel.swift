//
//  AboutWindow.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 12/28/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class AboutPanel: NSObject {

    var window: NSPanel!
    var information = AppInfoCollect()

    // Create the window programmatically
    func createWindow() {
        let screenSize = NSScreen.main?.frame
        let (windowSizeW, windowSizeH) = (CGFloat(250), CGFloat(180))
        let (origX, origY) = ((screenSize!.maxX - windowSizeW) / 2, (screenSize!.maxY - windowSizeH) / 2)
        if window == nil {
            window = NSPanel(contentRect: NSMakeRect(origX, origY, windowSizeW, windowSizeH),
                             styleMask: [.titled, .closable, .fullSizeContentView],
                             backing: .buffered,
                             defer: false)
            window.titlebarAppearsTransparent = true
            window.titleVisibility = .hidden
            //window.contentView?.wantsLayer = true
            //window.contentView?.layer?.contents = NSImage()
        }
        // Showing the window
        window.makeKeyAndOrderFront(self)
        //NSApp.activate(ignoringOtherApps: true)

        information.readInfoData()

        // Hidding the window
        //window.orderOut(self)
        //NSEvent.addLocalMonitorForEvents(matching: <#T##NSEvent.EventTypeMask#>, handler: <#T##(NSEvent) -> NSEvent?#>)
    }
}
