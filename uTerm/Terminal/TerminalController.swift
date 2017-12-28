//
//  TerminalController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 12/19/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class TerminalController: NSWindowController {
    // Tie the controller to its XIB file.
    override var windowNibName: NSNib.Name {
        return NSNib.Name("TerminalPanel")
    }


    override func windowDidLoad() {
        super.windowDidLoad()
    
        // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
    }

}
