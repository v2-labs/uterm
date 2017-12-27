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
    // List of supported terminal types (update to a dynamic gathering)
    private let termTypes = ["dumb", "vt-100", "term-16color", "term-256color"]
    // List of installed terminal interpreters (update to a dynamic gathering)
    private let termInterps = ["/bin/bash", "/bin/csh", "/bin/ksh", "/bin/sh", "/bin/tcsh", "/bin/zsh"]
    // Access to preferenceMsnager singleton
    private let preferenceManager = PreferenceManager.shared
    // View's subviews controls (outlets)
    @IBOutlet weak var terminalType: NSPopUpButton!
    @IBOutlet weak var terminalInterpreter: NSPopUpButton!


    /**
     Description:
     This delegate method is called when the view is created, so only one
     execution. This makes it really usefull for initialization stuff.
     I put here all view's control's initializations, so they were setup and
     ready for configuration later when viewed.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup the PopupButtons
        terminalType.removeAllItems()
        terminalType.addItems(withTitles: termTypes)
        terminalInterpreter.removeAllItems()
        terminalInterpreter.addItems(withTitles: termInterps)
    }

    /**
     Description:
     This delegate method is called every time the view is about to appear to
     the user. This makes it a nice point for update content prior to display.
     I put here all the view's control's update settings, so they are up-to-date
     for display.
    */
    override func viewWillAppear() {
        super.viewWillAppear()
        // .
        if termTypes.contains(preferenceManager.terminalType) {
            terminalType.selectItem(withTitle: preferenceManager.terminalType)
        }
        else {
            terminalType.selectItem(withTitle: termTypes[0])
        }
        print("terminalType PopupButton: \(terminalType.titleOfSelectedItem!)")
        //
        if termInterps.contains(preferenceManager.terminalInterpreter) {
            terminalInterpreter.selectItem(withTitle: preferenceManager.terminalInterpreter)
        }
        else {
            terminalInterpreter.selectItem(withTitle: termInterps[0])
        }
        print("terminalInterpreter PopupButton: \(terminalInterpreter.titleOfSelectedItem!)")
    }

    /**
     Description:
     This is the action to perform when the terminalType NSPopUpButtom changes
     selection. It basically updates the proper userDefaults key through the
     singleton preferenceManager property.
     */
    @IBAction func terminalType(_ sender: AnyObject) {
        if let termType = sender as? NSPopUpButton {
            preferenceManager.terminalType = termType.titleOfSelectedItem!
            print("PopUpButton 1: \(termType.titleOfSelectedItem!)")
            print("Preferences: \(preferenceManager.terminalType)")
        }
    }

    /**
     Description:
     This is the action to perform when the terminalInterpreter NSPopUpButtom
     changes selection. It basically updates the proper userDefaults key through
     the singleton preferenceManager property.
     */
    @IBAction func terminalInterpreter(_ sender: AnyObject) {
        if let termInterp = sender as? NSPopUpButton {
            preferenceManager.terminalInterpreter = termInterp.titleOfSelectedItem!
            print("PopUpButton 2: \(termInterp.titleOfSelectedItem!)")
            print("Preferences: \(preferenceManager.terminalInterpreter)")
        }
    }
}
