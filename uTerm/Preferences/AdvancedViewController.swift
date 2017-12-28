//
//  AdvancedViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 12/14/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class AdvancedViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {
    // Tie the controller to its XIB file.
    override var nibName: NSNib.Name {
        return NSNib.Name("PreferencesAdvancedView")
    }
    // Access to preferencesModel singleton
    private let preferencesModel = PreferencesModel.shared
    // View's subviews controls (outlets)
    @IBOutlet weak var loginMode: NSButton!
    @IBOutlet weak var environmentVars: NSTableView!

    // MARK: - AdvancedViewController delegate methods

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

    // MARK: - AdvancedViewController action methods

    /**
     */
    @IBAction func loginMode(_ sender: Any) {
        if let loginModeCheck = sender as? NSButton {
            preferencesModel.terminalUseLogin = (loginModeCheck.state == NSControl.StateValue.on)
            print("loginMode control: \(loginModeCheck.state)")
            print("loginMode preference: \(preferencesModel.terminalUseLogin)")
        }
        else {
            NSLog("")
        }
    }

    /**
     */
    @IBAction func modifyTableRows(_ sender: Any) {

    }

    /**
     */
    @IBAction func resetTableRows(_ sender: Any) {

    }

    // MARK: - AdvancedViewController private methods

    /**
     */
    fileprivate func setupViewElements() {
        // Configure the TableViewDelegate
        environmentVars.delegate = self
        // Configure the TableViewDataSource
        environmentVars.dataSource = self
    }

    /**
     */
    fileprivate func updateViewElements() {
        //
        loginMode.state = preferencesModel.terminalUseLogin ?
            NSControl.StateValue.on : NSControl.StateValue.off
        print("loginMode checkbox: \(loginMode.state)")
    }

    // MARK: - NSTableViewDelegate protocol methods

    /**
     */
    func tableViewSelectionDidChange(_ notification: Notification) {
        //.
        let row = environmentVars.selectedRow
        if row == -1 {
            //
        }
        else {
            //
        }
    }

    // MARK: - NSTableViewDataSource protocol methods

    /**
     */
    func numberOfRows(in tableView: NSTableView) -> Int {
        return preferencesModel.terminalEnvironment.count
    }

    /**
     */
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        if let dictRow = preferencesModel.terminalEnvironment[row] as? [String: String] {
            print("Row element: \(dictRow)")
            print("Column Key: \(tableColumn!.identifier.rawValue)")
            let element = dictRow[tableColumn!.identifier.rawValue]!
            print("Column element: \(element)")
            return element
        }
        else {
            NSLog("")
            return nil
        }
    }
}
