//
//  AppearanceViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class AppearanceViewController: NSViewController {
    // Tie the controller to its XIB file.
    override var nibName: NSNib.Name {
        return NSNib.Name("PreferencesAppearanceView")
    }

    //private let preferenceManager = PreferenceManager.shared

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
