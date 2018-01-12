//
//  PreferenceManager.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class PreferencesModel {
    // Single shared instance (Singleton)
    static let shared = PreferencesModel()
    // Get the instance of user preferences
    let userDefaults = UserDefaults()
    // Prepare an enum for the stored user' preferences keys
    enum Keys {
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
    // Some default values used internally
    private let defaultTerminalEnvironment: [[String:String]] = [ ["Name": "LC_CTYPE",
                                                                   "Value": "UTF-8"],
                                                                  ["Name": "PATH",
                                                                   "Value": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"],
                                                                  ["Name": "TERM",
                                                                   "Value": "dumb"],
                                                                  ["Name": "TERM_PROGRAM",
                                                                   "Value": "uTerm"]
    ]
    private let defaultTerminalFont: NSFont = NSFont.userFixedPitchFont(ofSize: CGFloat(0.0))!
    private let defaultColorBackground: NSColor = NSColor(red: 0.20, green: 0.20 ,blue: 0.20, alpha: 0.70)
    private let defaultColorForeground: NSColor = NSColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)

    // Computed properties based on the store Keys above
    var launchAtLogin: Bool {
        get {
            return userDefaults.bool(forKey: Keys.LaunchAtLogin)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.LaunchAtLogin)
        }
    }

    var activationHotKey: String {
        get {
            return userDefaults.string(forKey: Keys.ActivationHotKey)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.ActivationHotKey)
        }
    }

    var terminalType: String {
        get {
            return userDefaults.string(forKey: Keys.TerminalType)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalType)
        }
    }

    var terminalInterpreter: String {
        get {
            return userDefaults.string(forKey: Keys.TerminalInterpreter)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalInterpreter)
        }
    }

    var terminalFont: NSFont {
        get {
            if let data = userDefaults.object(forKey: Keys.TerminalFont) as? NSData {
                if let font = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSFont {
                    return font
                }
            }
            return defaultTerminalFont
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.TerminalFont)
        }
    }

    var colorBackground: NSColor {
        get {
            if let data = userDefaults.object(forKey: Keys.ColorBackground) as? NSData {
                if let backColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSColor {
                    return backColor
                }
            }
            return NSColor(red: 0.20, green: 0.20 ,blue: 0.20, alpha: 0.70)
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.ColorBackground)
        }
    }

    var colorForeground: NSColor {
        get {
            if let data = userDefaults.object(forKey: Keys.ColorForeground) as? NSData {
                if let foreColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSColor {
                    return foreColor
                }
            }
            return NSColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.ColorForeground)
        }
    }

    var terminalTextAntialias: Bool {
        get {
            return userDefaults.bool(forKey: Keys.TerminalTextAntialias)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalTextAntialias)
        }
    }
    
    var keepActionsResults: Int {
        get {
            return userDefaults.integer(forKey: Keys.KeepActionsResults)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.KeepActionsResults)
        }
    }

    var kindOfActivation: String {
        get {
            return userDefaults.string(forKey: Keys.KindOfActivation)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.KindOfActivation)
        }
    }
    
    var terminalUseLogin: Bool {
        get {
            return userDefaults.bool(forKey: Keys.TerminalUseLogin)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalUseLogin)
        }
    }

    var terminalEnvironment: [[String: String]] {
        get {
            return userDefaults.array(forKey: Keys.TerminalEnvironment) as! [[String: String]]
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalEnvironment)
        }
    }

    // Private initializer
    private init() {
        registerFactoryDefaults()
    }

    // Set factory defaults
    private func registerFactoryDefaults() {
        let factoryDefaults = [
                Keys.LaunchAtLogin: NSNumber(value: false),
                Keys.ActivationHotKey: "",
                Keys.KindOfActivation: "Screen",
                Keys.TerminalType: "dumb",
                Keys.TerminalInterpreter: "/bin/bash",
                Keys.TerminalFont: NSKeyedArchiver.archivedData(withRootObject: defaultTerminalFont),
                Keys.ColorBackground: NSKeyedArchiver.archivedData(withRootObject: defaultColorBackground),
                Keys.ColorForeground: NSKeyedArchiver.archivedData(withRootObject: defaultColorForeground),
                Keys.TerminalTextAntialias: NSNumber(value: true),
                Keys.KeepActionsResults: Int(5),
                Keys.TerminalUseLogin: NSNumber(value: false),
                Keys.TerminalEnvironment: defaultTerminalEnvironment,
            ] as [String : Any]
        // Register userDefaults with factoryDefaults
        userDefaults.register(defaults: factoryDefaults)
    }

    // Set terminal font to defaults
    func resetTerminalFont() {
        let data = NSKeyedArchiver.archivedData(withRootObject: defaultTerminalFont)
        userDefaults.set(data, forKey: Keys.TerminalFont)
    }

    // Set terminal environment to default
    func resetTerminalEnvironment() {
        userDefaults.set(defaultTerminalEnvironment, forKey: Keys.TerminalEnvironment)
    }

    // Reset all settings
    func reset() {
        userDefaults.removeObject(forKey: Keys.LaunchAtLogin)
        userDefaults.removeObject(forKey: Keys.ActivationHotKey)
        userDefaults.removeObject(forKey: Keys.KindOfActivation)
        userDefaults.removeObject(forKey: Keys.TerminalType)
        userDefaults.removeObject(forKey: Keys.TerminalInterpreter)
        userDefaults.removeObject(forKey: Keys.TerminalFont)
        userDefaults.removeObject(forKey: Keys.ColorBackground)
        userDefaults.removeObject(forKey: Keys.ColorForeground)
        userDefaults.removeObject(forKey: Keys.TerminalTextAntialias)
        userDefaults.removeObject(forKey: Keys.KeepActionsResults)
        userDefaults.removeObject(forKey: Keys.TerminalUseLogin)
        userDefaults.removeObject(forKey: Keys.TerminalEnvironment)
        synchronize()
    }

    // Manually update settings (should be automatic)
    func synchronize() {
        userDefaults.synchronize()
    }
}
