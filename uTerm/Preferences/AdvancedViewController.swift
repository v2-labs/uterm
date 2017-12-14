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


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        // Note: Beside this way, another way is directly bound to user defaults.
        //       Check the bind for "Warn before quit".
    }

}
