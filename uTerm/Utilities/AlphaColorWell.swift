//
//  AlphaColorWell.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 3/30/18.
//  Copyright © 2018 v2-lab. All rights reserved.
//

import Cocoa

class AlphaColorWell: NSColorWell {

    override func activate(_ exclusive: Bool) {
        NSColorPanel.shared.showsAlpha = true
        super.activate(exclusive)
    }

    override func deactivate() {
        super.deactivate()
        NSColorPanel.shared.showsAlpha = false
    }
}
