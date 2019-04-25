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
    private let defaultTerminalFont = NSFont.userFixedPitchFont(ofSize: CGFloat(0.0))!
    private let defaultColorBackground = NSColor(red: 0.20, green: 0.20 ,blue: 0.20, alpha: 0.70)
    private let defaultColorForeground = NSColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00)

    // Computed properties based on the store Keys above
    @objc dynamic var launchAtLogin: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaults.Key.LaunchAtLogin)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.LaunchAtLogin)
        }
    }

    @objc dynamic var activationHotKey: MASShortcut {
        get {
            if let data = userDefaults.object(forKey: UserDefaults.Key.ActivationHotKey) as? NSData {
                if let shortcut = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? MASShortcut {
                    return shortcut
                }
            }
            return defaultShortcut
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: UserDefaults.Key.ActivationHotKey)
        }
    }

    @objc dynamic var terminalType: String {
        get {
            return userDefaults.string(forKey: UserDefaults.Key.TerminalType)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.TerminalType)
        }
    }

    @objc dynamic var terminalInterpreter: String {
        get {
            return userDefaults.string(forKey: UserDefaults.Key.TerminalInterpreter)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.TerminalInterpreter)
        }
    }

    @objc dynamic var terminalFont: NSFont {
        get {
            if let data = userDefaults.object(forKey: UserDefaults.Key.TerminalFont) as? NSData {
                if let font = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSFont {
                    return font
                }
            }
            return defaultTerminalFont
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: UserDefaults.Key.TerminalFont)
        }
    }

    @objc dynamic var colorBackground: NSColor {
        get {
            if let data = userDefaults.object(forKey: UserDefaults.Key.ColorBackground) as? NSData {
                if let backColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSColor {
                    return backColor
                }
            }
            return defaultColorBackground
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: UserDefaults.Key.ColorBackground)
        }
    }

    @objc dynamic var colorForeground: NSColor {
        get {
            if let data = userDefaults.object(forKey: UserDefaults.Key.ColorForeground) as? NSData {
                if let foreColor = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? NSColor {
                    return foreColor
                }
            }
            return defaultColorForeground
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: UserDefaults.Key.ColorForeground)
        }
    }

    @objc dynamic var terminalTextAntialias: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaults.Key.TerminalTextAntialias)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.TerminalTextAntialias)
        }
    }
    
    @objc dynamic var keepActionsResults: Int {
        get {
            return userDefaults.integer(forKey: UserDefaults.Key.KeepActionsResults)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.KeepActionsResults)
        }
    }

    @objc dynamic var kindOfActivation: String {
        get {
            return userDefaults.string(forKey: UserDefaults.Key.KindOfActivation)!
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.KindOfActivation)
        }
    }
    
    @objc dynamic var terminalUseLogin: Bool {
        get {
            return userDefaults.bool(forKey: UserDefaults.Key.TerminalUseLogin)
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.TerminalUseLogin)
        }
    }

    @objc dynamic var terminalEnvironment: [[String: String]] {
        get {
            return userDefaults.array(forKey: UserDefaults.Key.TerminalEnvironment) as! [[String: String]]
        }
        set {
            userDefaults.set(newValue, forKey: UserDefaults.Key.TerminalEnvironment)
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
            UserDefaults.Key.LaunchAtLogin: NSNumber(value: false),
            UserDefaults.Key.ActivationHotKey: NSKeyedArchiver.archivedData(withRootObject: defaultShortcut!),
            UserDefaults.Key.KindOfActivation: "Screen",
            UserDefaults.Key.TerminalType: "dumb",
            UserDefaults.Key.TerminalInterpreter: "/bin/bash",
            UserDefaults.Key.TerminalFont: NSKeyedArchiver.archivedData(withRootObject: defaultTerminalFont),
            UserDefaults.Key.ColorBackground: NSKeyedArchiver.archivedData(withRootObject: defaultColorBackground),
            UserDefaults.Key.ColorForeground: NSKeyedArchiver.archivedData(withRootObject: defaultColorForeground),
            UserDefaults.Key.TerminalTextAntialias: NSNumber(value: true),
            UserDefaults.Key.KeepActionsResults: Int(5),
            UserDefaults.Key.TerminalUseLogin: NSNumber(value: false),
            UserDefaults.Key.TerminalEnvironment: defaultTerminalEnvironment,
        ] as [String : Any]
        // Register userDefaults with factoryDefaults
        userDefaults.register(defaults: factoryDefaults)
    }

    // Set terminal font to defaults
    func resetTerminalFont() {
        let data = NSKeyedArchiver.archivedData(withRootObject: defaultTerminalFont)
        userDefaults.set(data, forKey: UserDefaults.Key.TerminalFont)
    }

    // Set terminal environment to default
    func resetTerminalEnvironment() {
        userDefaults.set(defaultTerminalEnvironment, forKey: UserDefaults.Key.TerminalEnvironment)
    }

    // Reset all settings
    func reset() {
        userDefaults.removeObject(forKey: UserDefaults.Key.LaunchAtLogin)
        userDefaults.removeObject(forKey: UserDefaults.Key.ActivationHotKey)
        userDefaults.removeObject(forKey: UserDefaults.Key.KindOfActivation)
        userDefaults.removeObject(forKey: UserDefaults.Key.TerminalType)
        userDefaults.removeObject(forKey: UserDefaults.Key.TerminalInterpreter)
        userDefaults.removeObject(forKey: UserDefaults.Key.TerminalFont)
        userDefaults.removeObject(forKey: UserDefaults.Key.ColorBackground)
        userDefaults.removeObject(forKey: UserDefaults.Key.ColorForeground)
        userDefaults.removeObject(forKey: UserDefaults.Key.TerminalTextAntialias)
        userDefaults.removeObject(forKey: UserDefaults.Key.KeepActionsResults)
        userDefaults.removeObject(forKey: UserDefaults.Key.TerminalUseLogin)
        userDefaults.removeObject(forKey: UserDefaults.Key.TerminalEnvironment)
        synchronize()
    }

    // Manually update settings (should be automatic)
    func synchronize() {
        userDefaults.synchronize()
    }
}
