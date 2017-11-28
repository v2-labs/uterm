//
//  PreferencesViewController.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 10/31/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class PreferencesViewController: NSTabViewController {

    var tabViewSizes = [String: SizeArchiver]()
    private let preferenceManager = PreferenceManager.shared

    override func viewDidLoad() {
        readTabViewSizes()
        super.viewDidLoad()
    }

    override func viewWillDisappear() {
        super.viewWillDisappear()
        saveTabViewSizes()
    }

    func readTabViewSizes() {
        tabViewSizes = preferenceManager.tabViewSizes
        for tabViewItem in tabViewItems {
            let label = tabViewItem.label
            if tabViewSizes[label] == nil {
                if let size = tabViewItem.view?.frame.size {
                    tabViewSizes[label] = SizeArchiver(size: size)
                }
            }
        }
    }

    func saveTabViewSizes() {
        preferenceManager.tabViewSizes = tabViewSizes
        preferenceManager.synchronize()
    }

    override func tabView(_: NSTabView, willSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, willSelect: tabViewItem)

        // Save the size of the tab view item to be unselected
        if let selectedTabView = tabView.selectedTabViewItem {
            tabViewSizes[selectedTabView.label] = SizeArchiver(size: view.frame.size)
        }

        // Set the size of the tab view item to be selected
        if let tabViewItem = tabViewItem {
            if let size = tabViewSizes[tabViewItem.label]?.size {
                view.setFrameSize(size)
            }
        }
    }

    override func tabView(_: NSTabView, didSelect tabViewItem: NSTabViewItem?) {
        super.tabView(tabView, didSelect: tabViewItem)

        if let tabViewItem = tabView.selectedTabViewItem {
            if let window = view.window {
                window.title = tabViewItem.label

                if let size = tabViewSizes[tabViewItem.label] {
                    let contentFrame = window.frameRect(forContentRect: NSMakeRect(0.0, 0.0, size.width, size.height))

                    var frame = window.frame
                    frame.origin.y = frame.origin.y + (frame.size.height - contentFrame.size.height)
                    frame.size.height = contentFrame.size.height
                    frame.size.width = contentFrame.size.width
                    window.setFrame(frame, display: false, animate: true)
                }
            }
        }
    }
}
