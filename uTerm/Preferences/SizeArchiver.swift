//
//  SizeArchiver.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class SizeArchiver: NSObject, NSCoding {

    var size = NSSize()
    private static let sizeKey = "Size"

    var width: CGFloat {
        return size.width
    }

    var height: CGFloat {
        return size.height
    }

    override init() {
        super.init()
    }

    init(size: NSSize) {
        super.init()
        self.size = size
    }

    required init?(coder aDecoder: NSCoder) {
        super.init()
        self.size = aDecoder.decodeSize(forKey: SizeArchiver.sizeKey)
    }

    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.size, forKey: SizeArchiver.sizeKey)
    }
}
