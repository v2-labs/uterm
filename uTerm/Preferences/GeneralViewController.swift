//
//  GeneralViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa
import MASShortcut

class GeneralViewController: NSViewController {
    // MARK: - Properties
    // Tie the controller to its XIB file.
    override var nibName: NSNib.Name {
        return NSNib.Name("PreferencesGeneralView")
    }
    // Access the userDefaults preferences model singleton.
    private let preferencesModel = PreferencesModel.shared
    // Outlets for the view controls.
    @IBOutlet weak var launchAtLogin: NSButton!
    @IBOutlet weak var activationHotkey: MASShortcutView!
    @IBOutlet weak var activationMode: NSPopUpButton!
    // Values for some view controls (should be defined somewhere else?).
    let activationModes = ["Screen", "Window"]

    // MARK: - GeneralViewController

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
     *
     */
    @IBAction func launchAtLogin(_ sender: Any) {
        if let launchAtLoginCheck = sender as? NSButton {
            preferencesModel.launchAtLogin = (launchAtLoginCheck.state == NSControl.StateValue.on)
            #if DEBUG
                print("launchAtLogin control: \(launchAtLoginCheck.state)")
                print("launchAtLogin preferences: \(preferencesModel.launchAtLogin)")
            #endif
        }
        else {
            NSLog("")
        }
    }

    /**
     *
     */
    @IBAction func activationHotkey(_ sender: Any) {
        if let activationHotkey = sender as? MASShortcutView {
            let usedkey = PreferencesModel.Keys.ActivationHotKey
            var name = usedkey.rawValue
            preferencesModel.activationHotKey = activationHotkey.shortcutValue
            #if DEBUG
                print("activationHotkey control: \(activationHotkey.shortcutValue)")
                print("activationHotkey preference: \(preferencesModel.activationHotKey)")
            #endif
        }
        else {
            NSLog("")
        }
    }

    /**
     *
     */
    @IBAction func activationMode(_ sender: Any) {
        if let activationModeItem = sender as? NSPopUpButton {
            preferencesModel.kindOfActivation = activationModeItem.titleOfSelectedItem!
            #if DEBUG
                print("kindOfActivation control: \(activationModeItem.titleOfSelectedItem!)")
                print("kindOfActivation preference: \(preferencesModel.kindOfActivation)")
            #endif
        }
        else {
            NSLog("")
        }
    }

    // MARK: - GeneralViewController private methods

    /**
     *
     */
    fileprivate func setupViewElements() {
        //
        activationMode.removeAllItems()
        activationMode.addItems(withTitles: activationModes)
    }

    /**
     *
     */
    fileprivate func updateViewElements() {
        // Update the view controls contents
        // LaunchAtLogin
        launchAtLogin.state = preferencesModel.launchAtLogin ?
            NSControl.StateValue.on : NSControl.StateValue.off
        // ActivationHotKey
        activationHotkey.shortcutValue = preferencesModel.activationHotKey
        // KindOfActivation
        if activationModes.contains(preferencesModel.kindOfActivation) {
            activationMode.selectItem(withTitle: preferencesModel.kindOfActivation)
        }
        else {
            activationMode.selectItem(withTitle: preferencesModel.kindOfActivation)
        }
        #if DEBUG
            print("launchAtLogin checkbox: \(launchAtLogin.state)")
            print("activationHotkey value: \(activationHotkey.shortcutValue)")
            print("activationMode selection: \(activationMode.titleOfSelectedItem!)")
        #endif
    }
}
