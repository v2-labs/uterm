//
//  PreferenceManager.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa
import MASShortcut

class PreferencesModel: NSObject {
    // Single shared instance (Singleton)
    static let shared = PreferencesModel()
    // Get the instance of user preferences
    let userDefaults = UserDefaults()
    // Prepare an enum for the stored user' preferences keys
    enum Keys: String {
        case LaunchAtLogin = "launchAtLogin"
        case ActivationHotKey = "activationHotKey"
        case KindOfActivation = "kindOfActivation"
        case TerminalType = "terminalType"
        case TerminalInterpreter = "terminalInterpreter"
        case TerminalFont = "terminalFont"
        case ColorBackground = "colorBackground"
        case ColorForeground = "colorForeground"
        case TerminalTextAntialias = "terminalTextAntialias"
        case KeepActionsResults = "keepActionsResults"
        case TerminalUseLogin = "terminalUseLogin"
        case TerminalEnvironment = "terminalEnvironment"
    }
    // Some default values used internally
    private let defaultTerminalEnvironment: [[String:String]] = [
        [
            "Name":  "LC_CTYPE",
            "Value": "UTF-8"
        ],
        [
            "Name":  "PATH",
            "Value": "/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
        ],
        [
            "Name":  "TERM",
            "Value": "dumb"
        ],
        [
            "Name":  "TERM_PROGRAM",
            "Value": "uTerm"
        ]
    ]
    private let defaultShortcut: MASShortcut!
    private let defaultTerminalFont: NSFont = NSFont.userFixedPitchFont(ofSize: CGFloat(0.0))!
    private let defaultColorBackground: NSColor = NSColor(red: 0.20, green: 0.20 ,blue: 0.20, alpha: 0.70)
    private let defaultColorForeground: NSColor = NSColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)

    // Computed properties based on the store Keys above
    var launchAtLogin: Bool {
        get {
            return userDefaults.bool(forKey: Keys.LaunchAtLogin.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.LaunchAtLogin.rawValue)
        }
    }

    var activationHotKey: MASShortcut {
        get {
            if let data = userDefaults.object(forKey: Keys.ActivationHotKey.rawValue) as? NSData {
                if let shortcut = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? MASShortcut {
                    return shortcut
                }
            }
            return defaultShortcut
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.ActivationHotKey.rawValue)
        }
    }

    var terminalType: String {
        get {
            return userDefaults.string(forKey: Keys.TerminalType.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalType.rawValue)
        }
    }

    var terminalInterpreter: String {
        get {
            return userDefaults.string(forKey: Keys.TerminalInterpreter.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalInterpreter.rawValue)
        }
    }

    var terminalFont: NSFont {
        get {
            if let data = userDefaults.object(forKey: Keys.TerminalFont.rawValue) as? NSData {
                if let font = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSFont {
                    return font
                }
            }
            return defaultTerminalFont
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.TerminalFont.rawValue)
        }
    }

    var colorBackground: NSColor {
        get {
            if let data = userDefaults.object(forKey: Keys.ColorBackground.rawValue) as? NSData {
                if let backColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSColor {
                    return backColor
                }
            }
            return defaultColorBackground
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.ColorBackground.rawValue)
        }
    }

    var colorForeground: NSColor {
        get {
            if let data = userDefaults.object(forKey: Keys.ColorForeground.rawValue) as? NSData {
                if let foreColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSColor {
                    return foreColor
                }
            }
            return defaultColorForeground
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.ColorForeground.rawValue)
        }
    }

    var terminalTextAntialias: Bool {
        get {
            return userDefaults.bool(forKey: Keys.TerminalTextAntialias.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalTextAntialias.rawValue)
        }
    }
    
    var keepActionsResults: Int {
        get {
            return userDefaults.integer(forKey: Keys.KeepActionsResults.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.KeepActionsResults.rawValue)
        }
    }

    var kindOfActivation: String {
        get {
            return userDefaults.string(forKey: Keys.KindOfActivation.rawValue)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.KindOfActivation.rawValue)
        }
    }
    
    var terminalUseLogin: Bool {
        get {
            return userDefaults.bool(forKey: Keys.TerminalUseLogin.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalUseLogin.rawValue)
        }
    }

    var terminalEnvironment: [[String: String]] {
        get {
            return userDefaults.array(forKey: Keys.TerminalEnvironment.rawValue) as! [[String: String]]
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalEnvironment.rawValue)
        }
    }

    // Private initializer
    private override init() {
        // Set the default shortcut at initialization time
        let keyModifier: NSEvent.ModifierFlags = [.shift, .command]
        defaultShortcut = MASShortcut.init(keyCode: UInt(kVK_Space), modifierFlags: UInt(keyModifier.rawValue))
        // Give the superclass a chance to init itself
        super.init()
        // Fill the default settings
        registerFactoryDefaults()
    }

    // Set factory defaults
    private func registerFactoryDefaults() {
        let factoryDefaults = [
            Keys.LaunchAtLogin.rawValue: NSNumber(value: false),
            Keys.ActivationHotKey.rawValue: NSKeyedArchiver.archivedData(withRootObject: defaultShortcut),
            Keys.KindOfActivation.rawValue: "Screen",
            Keys.TerminalType.rawValue: "dumb",
            Keys.TerminalInterpreter.rawValue: "/bin/bash",
            Keys.TerminalFont.rawValue: NSKeyedArchiver.archivedData(withRootObject: defaultTerminalFont),
            Keys.ColorBackground.rawValue: NSKeyedArchiver.archivedData(withRootObject: defaultColorBackground),
            Keys.ColorForeground.rawValue: NSKeyedArchiver.archivedData(withRootObject: defaultColorForeground),
            Keys.TerminalTextAntialias.rawValue: NSNumber(value: true),
            Keys.KeepActionsResults.rawValue: Int(5),
            Keys.TerminalUseLogin.rawValue: NSNumber(value: false),
            Keys.TerminalEnvironment.rawValue: defaultTerminalEnvironment,
        ] as [String : Any]
        // Register userDefaults with factoryDefaults
        userDefaults.register(defaults: factoryDefaults)
    }

    // Set terminal font to defaults
    func resetTerminalFont() {
        let data = NSKeyedArchiver.archivedData(withRootObject: defaultTerminalFont)
        userDefaults.set(data, forKey: Keys.TerminalFont.rawValue)
    }

    // Set terminal environment to default
    func resetTerminalEnvironment() {
        userDefaults.set(defaultTerminalEnvironment, forKey: Keys.TerminalEnvironment.rawValue)
    }

    // Reset all settings
    func reset() {
        userDefaults.removeObject(forKey: Keys.LaunchAtLogin.rawValue)
        userDefaults.removeObject(forKey: Keys.ActivationHotKey.rawValue)
        userDefaults.removeObject(forKey: Keys.KindOfActivation.rawValue)
        userDefaults.removeObject(forKey: Keys.TerminalType.rawValue)
        userDefaults.removeObject(forKey: Keys.TerminalInterpreter.rawValue)
        userDefaults.removeObject(forKey: Keys.TerminalFont.rawValue)
        userDefaults.removeObject(forKey: Keys.ColorBackground.rawValue)
        userDefaults.removeObject(forKey: Keys.ColorForeground.rawValue)
        userDefaults.removeObject(forKey: Keys.TerminalTextAntialias.rawValue)
        userDefaults.removeObject(forKey: Keys.KeepActionsResults.rawValue)
        userDefaults.removeObject(forKey: Keys.TerminalUseLogin.rawValue)
        userDefaults.removeObject(forKey: Keys.TerminalEnvironment.rawValue)
        synchronize()
    }

    // Manually update settings (should be automatic)
    func synchronize() {
        userDefaults.synchronize()
    }
}
