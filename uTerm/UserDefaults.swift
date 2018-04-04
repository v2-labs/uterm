//
//  UserDefaults.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 4/1/18.
//  Copyright © 2018 v2-lab. All rights reserved.
//

import Foundation

extension UserDefaults {
    enum Key {
        static let LaunchAtLogin = "launchAtLogin"
        static let ActivationHotKey = "activationHotKey"
        static let KindOfActivation = "kindOfActivation"
        static let TerminalType = "terminalType"
        static let TerminalInterpreter = "terminalInterpreter"
        static let TerminalFont = "terminalFont"
        static let ColorBackground = "colorBackground"
        static let ColorForeground = "colorForeground"
        static let TerminalTextAntialias = "terminalTextAntialias"
        static let KeepActionsResults = "keepActionsResults"
        static let TerminalUseLogin = "terminalUseLogin"
        static let TerminalEnvironment = "terminalEnvironment"
    }
}
