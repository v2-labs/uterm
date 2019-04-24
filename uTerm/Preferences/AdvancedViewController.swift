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
        return "PreferencesAdvancedView"
    }
    // Access to preferencesModel singleton
    private let preferencesModel = PreferencesModel.shared
    // View's subviews controls (outlets)
    @IBOutlet weak var loginMode: NSButton!
    @IBOutlet weak var environmentVars: NSTableView!

    // MARK: - AdvancedViewController delegate methods

    /**
     *
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewElements()
    }

    /**
     *
     */
    override func viewWillAppear() {
        super.viewWillAppear()
        updateViewElements()
    }

    // MARK: - AdvancedViewController action methods

    /**
     *
     */
    @IBAction func loginMode(_ sender: Any) {
        if let loginModeCheck = sender as? NSButton {
            preferencesModel.terminalUseLogin = (loginModeCheck.state == NSControl.StateValue.on)
            #if DEBUG
                print("loginMode control: \(loginModeCheck.state)")
                print("loginMode preference: \(preferencesModel.terminalUseLogin)")
            #endif
        }
        else {
            NSLog("")
        }
    }

    /**
     *
     */
    @IBAction func modifyTableRows(_ sender: Any) {
        //
        if let modifyTableRows = sender as? NSSegmentedControl {
            // Adding new environment variable to the list
            if modifyTableRows.selectedSegment == 0 {
                // Inform the selected segment
                #if DEBUG
                    print("Segment 0 was selected")
                #endif
                // Define the insertion point
                let position = environmentVars.selectedRow == -1 ? preferencesModel.terminalEnvironment.count - 1 : environmentVars.selectedRow
                //
                preferencesModel.terminalEnvironment.insert([:], at: position + 1)
                //
                environmentVars.beginUpdates()
                environmentVars.insertRows(at: IndexSet(integer: position), withAnimation: .effectFade)
                environmentVars.endUpdates()
                //
                environmentVars.selectRowIndexes(IndexSet(integer: position + 1), byExtendingSelection: false)
            }
            // Remove *selected* environment variable from the list
            if modifyTableRows.selectedSegment == 1 {
                // Inform the selected segment
                #if DEBUG
                    print("Segment 1 was selected")
                #endif
                // Only remove *SELECTED* environment variables
                if environmentVars.selectedRow != -1 {
                    //
                    let selected = environmentVars.selectedRow
                    //
                    environmentVars.beginUpdates()
                    environmentVars.removeRows(at: IndexSet(integer: selected - 1), withAnimation: .effectFade)
                    environmentVars.endUpdates()
                    //
                    preferencesModel.terminalEnvironment.remove(at: selected)
                }
            }
        }
    }

    /**
     *
     */
    @IBAction func resetTableRows(_ sender: Any) {
        preferencesModel.resetTerminalEnvironment()
        environmentVars.reloadData()
    }

    // MARK: - AdvancedViewController private methods

    /**
     *
     */
    fileprivate func setupViewElements() {
        // Configure the TableViewDelegate
        environmentVars.delegate = self
        // Configure the TableViewDataSource
        environmentVars.dataSource = self
    }

    /**
     *
     */
    fileprivate func updateViewElements() {
        //
        loginMode.state = preferencesModel.terminalUseLogin ?
            NSControl.StateValue.on : NSControl.StateValue.off
        #if DEBUG
            print("loginMode checkbox: \(loginMode.state)")
        #endif
    }
}


// MARK: - NSTableViewDelegate
extension AdvancedViewController: NSTableViewDelegate {
    /**
     *
     */
    func tableViewSelectionDidChange(_ notification: Notification) {
        //
        if environmentVars.selectedRow == -1 {
            //
        }
        else {
            //
        }
    }
}


// MARK: - NSTableViewDataSource
extension AdvancedViewController: NSTableViewDataSource {
    /**
     *
     */
    func numberOfRows(in tableView: NSTableView) -> Int {
        return preferencesModel.terminalEnvironment.count
    }

    /**
     *
     */
    func tableView(_ tableView: NSTableView,
                   objectValueFor tableColumn: NSTableColumn?,
                   row: Int) -> Any? {
        let dictRow = preferencesModel.terminalEnvironment[row]
        #if DEBUG
            print("Row element: \(dictRow)")
            print("Column Key: \(tableColumn!.identifier.rawValue)")
        #endif
        if let element = dictRow[tableColumn!.identifier.rawValue] {
            #if DEBUG
                print("Column element: \(element)")
            #endif
            return element
        }
        else {
            return nil
        }
    }

    /**
     *
     */
    func tableView(_ aTableView: NSTableView,
                   setObjectValue anObject: Any?,
                   for aTableColumn: NSTableColumn?,
                   row rowIndex: Int) {
        #if DEBUG
            print("anObject: \(String(describing: anObject))")
            print("aTableColumn: \(String(describing: aTableColumn))")
            print("rowIndex: \(rowIndex)")
        #endif
        //
        if let newValue = anObject as? String,
           let tableColumn = aTableColumn {
            preferencesModel.terminalEnvironment[rowIndex][tableColumn.identifier.rawValue] = newValue
        }
    }
}
