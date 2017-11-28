//
//  PreferenceManager.swift
//  uTerm
//
//  Created by Juvenal A. Silva Jr. on 11/13/17.
//  Copyright © 2017 v2-lab. All rights reserved.
//

import Cocoa

class PreferenceManager {
    // Single shared instance (Singleton)
    static let shared = PreferenceManager()
    // Get the instance of user preferences
    let userDefaults = UserDefaults()
    // Prepare an enum for the stored user' preferences keys
    enum Keys {
        static let LaunchAtLogin = "launchAtLogin"
        static let ActivationHotKey = "activationHotKey"
        static let TerminalType = "terminalType"
        static let TerminalFont = "terminalFont"
        static let ColorBackground = "colorBackground"
        static let ColorForeground = "colorForeground"
        static let TerminalTextAntialias = "terminalTextAntialias"
        static let KeepActionsResults = "keepActionsResults"
        static let TabViewSizes = "tabViewSizes"
    }
    // Serializable CGRect to keep the window size
    private let defaultTabViewSizes = [String: SizeArchiver]()

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
            userDefaults.set(newValue, forKey: Keys.LaunchAtLogin)
        }
    }

    var terminalFont: [String: Any?] {
        get {
            return userDefaults.dictionary(forKey: Keys.TerminalFont)!
        }
        set {
            userDefaults.set(newValue, forKey: Keys.TerminalFont)
        }
    }

    var colorBackground: NSColor {
        get {
            if let data = userDefaults.object(forKey: Keys.ColorForeground) as? NSData {
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
    
    var tabViewSizes: [String: SizeArchiver] {
        get {
            if let data = userDefaults.object(forKey: Keys.TabViewSizes) as? NSData {
                if let sizes = NSKeyedUnarchiver.unarchiveObject(with: data as Data) as? [String: SizeArchiver] {
                    return sizes
                }
            }
            return defaultTabViewSizes
        }
        set {
            let data = NSKeyedArchiver.archivedData(withRootObject: newValue)
            userDefaults.set(data, forKey: Keys.TabViewSizes)
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
            Keys.TerminalType: "dumb",
            Keys.TerminalFont: ["Family":"Monaco", "Weight":"Regular", "Size":12],
            Keys.ColorBackground: NSColor(red: 0.20, green: 0.20 ,blue: 0.20, alpha: 0.70),
            Keys.ColorForeground: NSColor(red: 0.90, green: 0.90, blue: 0.90, alpha: 1.00),
            Keys.TerminalTextAntialias: NSNumber(value: true),
            Keys.KeepActionsResults: Int(5),
            Keys.TabViewSizes: defaultTabViewSizes,
            ] as [String : Any]

        userDefaults.register(defaults: factoryDefaults)
    }

    // Reset settings
    func reset() {
        userDefaults.removeObject(forKey: Keys.LaunchAtLogin)
        userDefaults.removeObject(forKey: Keys.ActivationHotKey)
        userDefaults.removeObject(forKey: Keys.TerminalType)
        userDefaults.removeObject(forKey: Keys.TerminalFont)
        userDefaults.removeObject(forKey: Keys.ColorBackground)
        userDefaults.removeObject(forKey: Keys.ColorForeground)
        userDefaults.removeObject(forKey: Keys.TerminalTextAntialias)
        userDefaults.removeObject(forKey: Keys.KeepActionsResults)
        userDefaults.removeObject(forKey: Keys.TabViewSizes)
        synchronize()
    }

    // Manually update settings (should be automatic)
    func synchronize() {
        userDefaults.synchronize()
    }
}
