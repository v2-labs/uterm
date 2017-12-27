//
//  GeneralViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class GeneralViewController: NSViewController {
    // Tie the controller to its XIB file.
    override var nibName: NSNib.Name {
        return NSNib.Name("PreferencesGeneralView")
    }
    // .
    let activationModes = ["Screen", "Window"]
    // .
    private let preferenceManager = PreferenceManager.shared
    // .
    @IBOutlet weak var launchAtLogin: NSButton!
    @IBOutlet weak var activationHotkey: NSTextField!
    @IBOutlet weak var activationMode: NSPopUpButton!
    // .


    override func viewDidLoad() {
        super.viewDidLoad()
        //
        activationMode.removeAllItems()
        activationMode.addItems(withTitles: activationModes)
    }

    override func viewWillAppear() {
        super.viewWillAppear()
        // Update the view controls contents
        launchAtLogin.state = preferenceManager.launchAtLogin ?
                                NSControl.StateValue.on : NSControl.StateValue.off
        print("launchAtLogin checkbox: \(launchAtLogin.state)")
        // .
        activationHotkey.stringValue = preferenceManager.activationHotKey
        print("activationHotkey string: \(activationHotkey.stringValue)")
        // .
        if activationModes.contains(preferenceManager.kindOfActivation) {
            activationMode.selectItem(withTitle: preferenceManager.kindOfActivation)
        }
        else {
            activationMode.selectItem(withTitle: preferenceManager.kindOfActivation)
        }
        print("activationMode selection: \(activationMode.titleOfSelectedItem!)")
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        // Note: Beside this way, another way is directly bound to user defaults.

    }

    @IBAction func launchAtLogin(_ sender: NSButton) {
        preferenceManager.launchAtLogin = (launchAtLogin.state == NSControl.StateValue.on)
        print("launchAtLogin control: \(launchAtLogin.state)")
        print("launchAtLogin preferences: \(preferenceManager.launchAtLogin)")
    }

    @IBAction func activationHotkey(_ sender: NSTextField) {
        preferenceManager.activationHotKey = activationHotkey.stringValue
        print("activationHotkey control: \(activationHotkey.stringValue)")
        print("activationHotkey preference: \(preferenceManager.activationHotKey)")
    }

    @IBAction func activationMode(_ sender: NSPopUpButton) {
        preferenceManager.kindOfActivation = activationMode.titleOfSelectedItem!
        print("kindOfActivation control: \(activationMode.titleOfSelectedItem!)")
        print("kindOfActivation preference: \(preferenceManager.kindOfActivation)")
    }
}
