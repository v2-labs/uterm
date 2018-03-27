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
    private let preferencesModel = PreferencesModel.shared
    // View's subviews controls (outlets)
    @IBOutlet weak var terminalType: NSPopUpButton!
    @IBOutlet weak var terminalInterpreter: NSPopUpButton!
    @IBOutlet weak var terminalFont: NSButton!
    @IBOutlet weak var fontPreview: NSTextField!
    @IBOutlet weak var backColor: NSColorWell!
    @IBOutlet weak var frontColor: NSColorWell!


    // MARK: - AppearanceViewController delegate methods

    /**
     Description:
     This delegate method is called when the view is created, so only one
     execution. This makes it really usefull for initialization stuff.
     I put here all view's control's initializations, so they were setup and
     ready for configuration later when viewed.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewElements()
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
        updateViewElements()
    }

    // MARK: - AppearanceViewController private methods

    /**
     */
    fileprivate func setupViewElements() {
        // Setup the PopUpButtons
        terminalType.removeAllItems()
        terminalType.addItems(withTitles: termTypes)
        terminalInterpreter.removeAllItems()
        terminalInterpreter.addItems(withTitles: termInterps)
    }

    /**
     */
    fileprivate func updateViewElements() {
        // Update the PopUpButtons status and values
        if termTypes.contains(preferencesModel.terminalType) {
            terminalType.selectItem(withTitle: preferencesModel.terminalType)
        }
        else {
            terminalType.selectItem(withTitle: termTypes[0])
        }
        print("terminalType PopupButton: \(terminalType.titleOfSelectedItem!)")
        //
        if termInterps.contains(preferencesModel.terminalInterpreter) {
            terminalInterpreter.selectItem(withTitle: preferencesModel.terminalInterpreter)
        }
        else {
            terminalInterpreter.selectItem(withTitle: termInterps[0])
        }
        print("terminalInterpreter PopupButton: \(terminalInterpreter.titleOfSelectedItem!)")
        //
        backColor.color = preferencesModel.colorBackground
        frontColor.color = preferencesModel.colorForeground
        //
        //let fontManager = NSFontManager.shared
        
    }

    // MARK: - AppearanceViewController action methods

    /**
     Description:
     This is the action to perform when the terminalType NSPopUpButtom changes
     selection. It basically updates the proper userDefaults key through the
     singleton preferencesModel property.
     */
    @IBAction func terminalType(_ sender: Any) {
        if let termType = sender as? NSPopUpButton {
            preferencesModel.terminalType = termType.titleOfSelectedItem!
            print("PopUpButton 1: \(termType.titleOfSelectedItem!)")
            print("Preferences: \(preferencesModel.terminalType)")
        }
        else {
            NSLog("")
        }
    }

    /**
     Description:
     This is the action to perform when the terminalInterpreter NSPopUpButtom
     changes selection. It basically updates the proper userDefaults key through
     the singleton preferencesModel property.
     */
    @IBAction func terminalInterpreter(_ sender: Any) {
        if let termInterp = sender as? NSPopUpButton {
            preferencesModel.terminalInterpreter = termInterp.titleOfSelectedItem!
            print("PopUpButton 2: \(termInterp.titleOfSelectedItem!)")
            print("Preferences: \(preferencesModel.terminalInterpreter)")
        }
        else {
            NSLog("")
        }
    }

    /**
     */
    @IBAction func changeTerminalFont(_ sender: Any) {
        //
        let fontPanel = NSFontPanel.shared
        let fontManager = NSFontManager.shared
        fontPanel.orderFront(self)
        fontManager.target = self
        preferencesModel.terminalFont = fontManager.selectedFont!
    }


    @IBAction func changeBackgroundColor(_ sender: Any) {
        //
        preferencesModel.colorBackground = backColor.color
    }


    @IBAction func changeForegroundColor(_ sender: Any) {
        //
        preferencesModel.colorForeground = frontColor.color
    }
}
