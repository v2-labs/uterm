//
//  AppInfoCollect.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 3/30/18.
//  Copyright © 2018 v2-lab. All rights reserved.
//

import Cocoa

class AppInfoCollect: NSObject {
    var appInfo: [String:String] = [:]

    // Collect the Bundle Info.plist content
    func readInfoData() {
        if let infoPlistDictionary = Bundle.main.infoDictionary as NSDictionary? {
            var infoPlistContent = infoPlistDictionary as? [String:AnyObject]
            if let appName = infoPlistContent!["CFBundleExecutable"] as? String,
                let appVersion = infoPlistContent!["CFBundleShortVersionString"] as? String,
                let appCommitID = infoPlistContent!["CFBundleVersion"] as? String,
                let appCopyright = infoPlistContent!["NSHumanReadableCopyright"] as? String,
                let appMinSystem = infoPlistContent!["LSMinimumSystemVersion"] as? String {
                appInfo["name"] = appName
                appInfo["version"] = appVersion
                appInfo["commitID"] = appCommitID
                appInfo["copyright"] = appCopyright
                appInfo["macOSMinVer"] = appMinSystem
                appInfo["developmentText"] = ""
                #if DEBUG
                    print("Application name: \(appInfo["name"]!), commit: \(appInfo["commitID"]!), version: \(appInfo["version"]!), copyright: \(appInfo["copyright"]!), minimum macOS required: \(appInfo["macOSMinVer"]!)")
                    print("Dictionary: \(String(describing: infoPlistContent))")
                #endif
            }
        }
    }

}
