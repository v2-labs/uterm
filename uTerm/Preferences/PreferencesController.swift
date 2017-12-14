//
//  PreferencesController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 10/31/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class PreferencesController: NSWindowController, NSToolbarDelegate {
    // Tie the controller to its XIB file.
    override var windowNibName: NSNib.Name {
        return NSNib.Name("PreferencesPanel")
    }
    // Define toolbar elements names
    let toolbarNames = ["General",
                        "Appearance",
                        "Advanced"]
    // Define toolbar elements definitions
    let toolbarItems = ["General":    ["label":    "General",
                                       "palette":  "General",
                                       "tooltip":  "General options",
                                       "image":    "NSPreferencesGeneral"],
                        "Appearance": ["label":    "Appearance",
                                       "palette":  "Appearance",
                                       "tooltip":  "Appearance options",
                                       "image":    "NSStatusAvailable"],
                        "Advanced":   ["label":    "Advanced",
                                       "palette":  "Advanced",
                                       "tooltip":  "Advanced options",
                                       "image":    "NSAdvanced"]
    ]
    // View display control properties
    var currentView = ""
    // Set the active current view controller
    var currentViewController:NSViewController!

    // MARK: - PreferencesController

    /**
        Implement this method to handle any initialization after your window controller's window
        has been loaded from its nib file.
    */
    override func windowDidLoad() {
        super.windowDidLoad()
        // Create the preferences toolbar element for tabview control
        let toolbar = NSToolbar(identifier: NSToolbar.Identifier(rawValue: "preferencesToolbar"))
        toolbar.displayMode = .iconAndLabel
        toolbar.sizeMode = .regular
        toolbar.allowsUserCustomization = false
        toolbar.autosavesConfiguration = false
        toolbar.delegate = self
        // Attach the created toolbar to the preferences NSPanel
        self.window!.toolbar = toolbar
    }

    // Managament of preference NSPanel views
    @IBAction func viewSelected(sender: NSToolbarItem) {
        loadView(viewIdentifier: sender.itemIdentifier.rawValue, withAnimation: true)
    }

    func loadView(viewIdentifier: String, withAnimation shouldAnimate:Bool) {
        if self.currentView == viewIdentifier {
            return
        }
        self.currentView = viewIdentifier
        // Set the new view controller
        if self.currentView == "General" {
            //
            self.currentViewController = GeneralViewController()
        }
        else if self.currentView == "Appearance" {
            //
            self.currentViewController = AppearanceViewController()
        }
        else if self.currentView == "Advanced" {
            //
            self.currentViewController = AdvancedViewController()
        }
        // Collect its bounds and frame
        let newView = self.currentViewController.view
        let windowRect = self.window!.frame
        let currentViewRect = newView.frame
        // Calculate the new window size for new view
        self.window!.contentView = newView
        let yPos = windowRect.origin.y + (windowRect.size.height - (currentViewRect.size.height + 80))
        let newFrame = NSMakeRect(windowRect.origin.x, yPos, currentViewRect.size.width, currentViewRect.size.height + 80)
        // Adjust the window for the new size (with possible animation)
        self.window!.setFrame(newFrame, display: true, animate: shouldAnimate)
    }

    // MARK: - NSToolbarDelegate

    // Implement ToolbarDelegate methods that control the NSPanel ViewController
    func toolbar(_ toolbar: NSToolbar, itemForItemIdentifier itemIdentifier: NSToolbarItem.Identifier, willBeInsertedIntoToolbar flag: Bool) -> NSToolbarItem?
    {
        var toolbarItem: NSToolbarItem?
        for tbItem in self.toolbarNames {
            if itemIdentifier.rawValue == tbItem {
                var tbItemData = self.toolbarItems[tbItem]
                let imageNamed = NSImage(named: NSImage.Name(rawValue: tbItemData!["image"]!))
                toolbarItem = NSToolbarItem(itemIdentifier: NSToolbarItem.Identifier(rawValue: tbItem))
                toolbarItem!.label = tbItemData!["label"]!
                toolbarItem!.paletteLabel = tbItemData!["palette"]!
                toolbarItem!.toolTip = tbItemData!["tooltip"]!
                toolbarItem!.image = imageNamed
                toolbarItem!.target = self
                toolbarItem!.action = #selector(self.viewSelected)
                break
            }
        }
        return toolbarItem;
    }

    func toolbarAllowedItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [NSToolbarItem.Identifier(rawValue: self.toolbarNames[0]),
                NSToolbarItem.Identifier(rawValue: self.toolbarNames[1]),
                NSToolbarItem.Identifier(rawValue: self.toolbarNames[2])]
    }

    func toolbarDefaultItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [NSToolbarItem.Identifier(rawValue: self.toolbarNames[0]),
                NSToolbarItem.Identifier(rawValue: self.toolbarNames[1]),
                NSToolbarItem.Identifier(rawValue: self.toolbarNames[2])]
    }

    func toolbarSelectableItemIdentifiers(_ toolbar: NSToolbar) -> [NSToolbarItem.Identifier]
    {
        return [NSToolbarItem.Identifier(rawValue: self.toolbarNames[0]),
                NSToolbarItem.Identifier(rawValue: self.toolbarNames[1]),
                NSToolbarItem.Identifier(rawValue: self.toolbarNames[2])]
    }
}
