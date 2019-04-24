//
//  AppearanceViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class AppearanceViewController: NSViewController {
    // MARK: - Properties
    // Tie the controller to its XIB file.
    override var nibName: NSNib.Name {
        return "PreferencesAppearanceView"
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
    @IBOutlet weak var backColor: AlphaColorWell!
    @IBOutlet weak var frontColor: AlphaColorWell!


    // MARK: - AppearanceViewController

    /**
     * Description:
     *   This delegate method is called when the view is created, so only one
     *   execution. This makes it really usefull for initialization stuff.
     *   I put here all view's control's initializations, so they were setup and
     *   ready for configuration later when viewed.
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewElements()
    }

    /**
     * Description:
     *   This delegate method is called every time the view is about to appear
     *   to the user. This makes it a nice point for update content prior to
     *   display. I put here all the view's control's update settings, so they
     *   are up-to-date for display.
    */
    override func viewWillAppear() {
        super.viewWillAppear()
        updateViewElements()
    }

    // MARK: - AppearanceViewController private methods

    /**
     *
     */
    fileprivate func setupViewElements() {
        // Setup the PopUpButtons
        terminalType.removeAllItems()
        terminalType.addItems(withTitles: termTypes)
        terminalInterpreter.removeAllItems()
        terminalInterpreter.addItems(withTitles: termInterps)
    }

    /**
     *
     */
    fileprivate func updateViewElements() {
        // Update the PopUpButtons status and values
        if termTypes.contains(preferencesModel.terminalType) {
            terminalType.selectItem(withTitle: preferencesModel.terminalType)
        }
        else {
            terminalType.selectItem(withTitle: termTypes[0])
        }
        //
        if termInterps.contains(preferencesModel.terminalInterpreter) {
            terminalInterpreter.selectItem(withTitle: preferencesModel.terminalInterpreter)
        }
        else {
            terminalInterpreter.selectItem(withTitle: termInterps[0])
        }
        //
        //let fontManager = NSFontManager.shared
        //
        backColor.color = preferencesModel.colorBackground
        frontColor.color = preferencesModel.colorForeground
        #if DEBUG
            print("terminalType PopupButton: \(terminalType.titleOfSelectedItem!)")
            print("terminalInterpreter PopupButton: \(terminalInterpreter.titleOfSelectedItem!)")
            //print("fontManager selection: \(fontManager.)")
            print("backgroundColor selection: \(backColor.color)")
            print("foregroundColor selection: \(frontColor.color)")
        #endif
    }

    // MARK: - AppearanceViewController action methods

    /**
     * Description:
     *   This is the action to perform when the terminalType NSPopUpButtom
     *   chages selection. It basically updates the proper userDefaults key
     *   through the singleton preferencesModel property.
     */
    @IBAction func terminalType(_ sender: Any) {
        if let termType = sender as? NSPopUpButton {
            preferencesModel.terminalType = termType.titleOfSelectedItem!
            #if DEBUG
                print("PopUpButton 1: \(termType.titleOfSelectedItem!)")
                print("Preferences: \(preferencesModel.terminalType)")
            #endif
        }
        else {
            NSLog("")
        }
    }

    /**
     * Description:
     *   This is the action to perform when the terminalInterpreter NSPopUpButtom
     *   changes selection. It basically updates the proper userDefaults key through
     *   the singleton preferencesModel property.
     */
    @IBAction func terminalInterpreter(_ sender: Any) {
        if let termInterp = sender as? NSPopUpButton {
            preferencesModel.terminalInterpreter = termInterp.titleOfSelectedItem!
            #if DEBUG
                print("PopUpButton 2: \(termInterp.titleOfSelectedItem!)")
                print("Preferences: \(preferencesModel.terminalInterpreter)")
            #endif
        }
        else {
            NSLog("")
        }
    }

    /**
     *
     */
    @IBAction func changeTerminalFont(_ sender: Any) {
        //
        let fontPanel = NSFontPanel.shared
        let fontManager = NSFontManager.shared
        fontPanel.orderFront(self)
        fontManager.target = self
        preferencesModel.terminalFont = fontManager.selectedFont!
    }


    /**
     *
     */
    @IBAction func changeBackgroundColor(_ sender: Any) {
        //
        preferencesModel.colorBackground = backColor.color
        #if DEBUG
            print("backgroundColor selected: \(backColor.color)")
        #endif
    }


    /**
     *
     */
    @IBAction func changeForegroundColor(_ sender: Any) {
        //
        preferencesModel.colorForeground = frontColor.color
        #if DEBUG
            print("foregroundColor selected: \(frontColor.color)")
        #endif
    }
}
