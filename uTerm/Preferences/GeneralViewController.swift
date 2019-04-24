//
//  GeneralViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa
import MASShortcut

// Define some file local variables and constants
//private var generalControls = 1
private let activationHotKey = "activationHotKey"


class GeneralViewController: NSViewController {
    private static var generalControls = 1
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
                debugPrint("launchAtLogin control: \(launchAtLoginCheck.state)")
                debugPrint("launchAtLogin preferences: \(preferencesModel.launchAtLogin)")
            #endif
        }
        else {
            debugPrint("")
        }
    }

    /**
     *
     */
    //@IBAction func activationHotkey(_ sender: Any) {
    //    if let activationHotkey = sender as? MASShortcutView {
    //        //let usedkey = PreferencesModel.Keys.ActivationHotKey
    //        //var name = usedkey.rawValue
    //        preferencesModel.activationHotKey = activationHotkey.shortcutValue
    //        #if DEBUG
    //            debugPrint("activationHotkey control: \(activationHotkey.shortcutValue)")
    //            debugPrint("activationHotkey preference: \(preferencesModel.activationHotKey)")
    //        #endif
    //    }
    //    else {
    //        debugPrint("")
    //    }
    //}

    /**
     *
     */
    @IBAction func activationMode(_ sender: Any) {
        if let activationModeItem = sender as? NSPopUpButton {
            preferencesModel.kindOfActivation = activationModeItem.titleOfSelectedItem!
            #if DEBUG
                debugPrint("kindOfActivation control: \(activationModeItem.titleOfSelectedItem!)")
                debugPrint("kindOfActivation preference: \(preferencesModel.kindOfActivation)")
            #endif
        }
        else {
            debugPrint("")
        }
    }

    /**
     *
     */
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &GeneralViewController.generalControls {
            if keyPath == activationHotKey {
                MASShortcutBinder.shared().bindShortcut(withDefaultsKey: UserDefaults.Key.ActivationHotKey, toAction: {
                        print("Hello world")
                    })
            }
        }
        else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

    // MARK: - GeneralViewController private methods

    /**
     *
     */
    fileprivate func setupViewElements() {
        //
        /*
        launchAtLogin.bind(NSBindingName("launchAtLogin"), to: preferencesModel, withKeyPath: "self.launchAtLogin", options: nil)
        bind(<#T##binding: NSBindingName##NSBindingName#>, to: <#T##Any#>, withKeyPath: <#T##String#>, options: <#T##[NSBindingOption : Any]?#>)
        bind(NSBindingName(""), to: <#T##Any#>, withKeyPath: <#T##String#>, options: <#T##[NSBindingOption : Any]?#>)
        addObserver(self.preferencesModel, forKeyPath: "launchAtLogin", options: <#T##NSKeyValueObservingOptions#>, context: <#T##UnsafeMutableRawPointer?#>)
        */
        activationMode.removeAllItems()
        activationMode.addItems(withTitles: activationModes)
        preferencesModel.addObserver(self, forKeyPath: activationHotKey,
                                              options: [.initial, .new],
                                              context: &GeneralViewController.generalControls)
        activationHotkey.associatedUserDefaultsKey = UserDefaults.Key.ActivationHotKey
        //observe(<#T##keyPath: KeyPath<_KeyValueCodingAndObserving, Value>##KeyPath<_KeyValueCodingAndObserving, Value>#>, changeHandler: <#T##(_KeyValueCodingAndObserving, NSKeyValueObservedChange<Value>) -> Void#>)
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
            activationMode.selectItem(withTitle: activationModes[0])
        }
        #if DEBUG
            debugPrint("launchAtLogin checkbox: \(launchAtLogin.state)")
            debugPrint("activationHotkey value: \(String(describing: activationHotkey.shortcutValue))")
            debugPrint("activationMode selection: \(activationMode.titleOfSelectedItem!)")
        #endif
    }
}
