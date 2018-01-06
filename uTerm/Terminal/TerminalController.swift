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
        // Setup the window

        // Move the window into view with appropriate size
        slideWindowDown(to: CGPoint(x: 100, y: 100), size: CGPoint(x: 200, y: 350), animated: true)
        // Activate and
    }



    // MARK: - TerminalController private methods
    fileprivate func slideWindowDown(to: CGPoint, size: CGPoint, animated: Bool) {
        //
    }
}
