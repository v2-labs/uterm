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
    // Access the userDefaults preferences model singleton.
    private let preferencesModel = PreferencesModel.shared
    // Outlets for the view controls.
    @IBOutlet weak var launchAtLogin: NSButton!
    // @IBOutlet weak var activationHotkey: MASShortcutView!
    @IBOutlet weak var activationHotkey: NSTextView!
    @IBOutlet weak var activationMode: NSPopUpButton!
    // Values for some view controls (should be defined somewhere else?).
    let activationModes = ["Screen", "Window"]

    // MARK: - GeneralViewController delegate methods

    /**
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewElements()
    }

    /**
     */
    override func viewWillAppear() {
        super.viewWillAppear()
        updateViewElements()
    }

    /**
     */
    override func viewWillDisappear() {
        super.viewWillDisappear()
        //.
    }

    // MARK: - GeneralViewController action methods

    /**
     */
    @IBAction func launchAtLogin(_ sender: Any) {
        if let launchAtLoginCheck = sender as? NSButton {
            preferencesModel.launchAtLogin = (launchAtLoginCheck.state == NSControl.StateValue.on)
            print("launchAtLogin control: \(launchAtLoginCheck.state)")
            print("launchAtLogin preferences: \(preferencesModel.launchAtLogin)")
        }
        else {
            NSLog("")
        }
    }

    /**
     */
    @IBAction func activationHotkey(_ sender: Any) {
        if let activationHotkeyText = sender as? NSTextField {
            preferencesModel.activationHotKey = activationHotkeyText.stringValue
            print("activationHotkey control: \(activationHotkeyText.stringValue)")
            print("activationHotkey preference: \(preferencesModel.activationHotKey)")
        }
        else {
            NSLog("")
        }
    }

    /**
     */
    @IBAction func activationMode(_ sender: Any) {
        if let activationModeItem = sender as? NSPopUpButton {
            preferencesModel.kindOfActivation = activationModeItem.titleOfSelectedItem!
            print("kindOfActivation control: \(activationModeItem.titleOfSelectedItem!)")
            print("kindOfActivation preference: \(preferencesModel.kindOfActivation)")
        }
        else {
            NSLog("")
        }
    }

    // MARK: - GeneralViewController private methods

    /**
     */
    fileprivate func setupViewElements() {
        //
        activationMode.removeAllItems()
        activationMode.addItems(withTitles: activationModes)
    }

    /**
     */
    fileprivate func updateViewElements() {
        // Update the view controls contents
        launchAtLogin.state = preferencesModel.launchAtLogin ?
            NSControl.StateValue.on : NSControl.StateValue.off
        print("launchAtLogin checkbox: \(launchAtLogin.state)")
        // .
        //activationHotkey.stringValue = preferencesModel.activationHotKey
        //print("activationHotkey string: \(activationHotkey.stringValue)")
        // .
        if activationModes.contains(preferencesModel.kindOfActivation) {
            activationMode.selectItem(withTitle: preferencesModel.kindOfActivation)
        }
        else {
            activationMode.selectItem(withTitle: preferencesModel.kindOfActivation)
        }
        print("activationMode selection: \(activationMode.titleOfSelectedItem!)")
    }
}
