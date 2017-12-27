//
//  AdvancedViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 12/14/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class AdvancedViewController: NSViewController {
    // Tie the controller to its XIB file.
    override var nibName: NSNib.Name {
        return NSNib.Name("PreferencesAdvancedView")
    }
    // Access to preferenceMsnager singleton
    private let preferenceManager = PreferenceManager.shared
    // View's subviews controls (outlets)
    @IBOutlet weak var loginMode: NSButton!
    @IBOutlet weak var environmentVars: NSTableView!


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        //
        loginMode.state = preferenceManager.terminalUseLogin ?
                            NSControl.StateValue.on : NSControl.StateValue.off
        print("loginMode checkbox: \(loginMode.state)")
    }

    @IBAction func loginMode(_ sender: NSButton) {
        preferenceManager.terminalUseLogin = (loginMode.state == NSControl.StateValue.on)
        print("loginMode control: \(loginMode.state)")
        print("loginMode preference: \(preferenceManager.terminalUseLogin)")
    }

    @IBAction func modifyTableRows(_ sender: Any) {

    }

    @IBAction func resetTableRows(_ sender: Any) {

    }
}
