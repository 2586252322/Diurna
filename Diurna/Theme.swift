//
//  Theme.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 28/01/2017.
//  Copyright © 2017 Nicolas Gaulard-Querol. All rights reserved.
//

import Cocoa

extension Notification.Name {
    static let ThemeChangedNotification = Notification.Name("ThemeChangedNotification")
}

protocol Themeable {
    func updateColors(from theme: ColorTheme)
}

protocol ColorTheme {
    var normalTextColor: NSColor { get }
    var primaryTextColor: NSColor { get }
    var secondaryTextColor: NSColor { get }
    var disabledTextColor: NSColor { get }
    var dividerColor: NSColor { get }
    var backgroundColor: NSColor { get }
    var cellHighlightForegroundColor: NSColor { get }
    var cellHighlightBackgroundColor: NSColor { get }
    var opBadgeColor: NSColor { get }
    var codeBlockColor: NSColor { get }
    var urlColor: NSColor { get }
    var visualEffectAppearance: NSAppearance { get }
}

extension ColorTheme {
    var primaryTextColor: NSColor { return normalTextColor.withAlphaComponent(1) }
    var secondaryTextColor: NSColor { return normalTextColor.withAlphaComponent(0.7) }
    var disabledTextColor: NSColor { return normalTextColor.withAlphaComponent(0.5) }
    var dividerColor: NSColor { return backgroundColor.blended(withFraction: 0.2, of: primaryTextColor)! }
}

struct LightTheme: ColorTheme {
    let normalTextColor = NSColor.black
    let backgroundColor = NSColor.white
    let cellHighlightForegroundColor = NSColor(calibratedRed: 21 / 255, green: 123 / 255, blue: 242 / 255, alpha: 1)
    let cellHighlightBackgroundColor = NSColor(calibratedRed: 244 / 255, green: 249 / 255, blue: 255 / 255, alpha: 1)
    let opBadgeColor = NSColor(calibratedRed: 76 / 255, green: 197 / 255, blue: 76 / 255, alpha: 1)
    let codeBlockColor = NSColor(calibratedWhite: 0.9, alpha: 1)
    let urlColor = NSColor.blue
    let visualEffectAppearance = NSAppearance(named: .vibrantLight)!

    fileprivate init() {}
}

struct DarkTheme: ColorTheme {
    let normalTextColor = NSColor.white
    let backgroundColor = NSColor(calibratedRed: 33 / 255, green: 33 / 255, blue: 33 / 255, alpha: 1)
    let cellHighlightForegroundColor = NSColor.white
    let cellHighlightBackgroundColor = NSColor(calibratedRed: 66 / 255, green: 66 / 255, blue: 66 / 255, alpha: 1)
    let opBadgeColor = NSColor(calibratedRed: 76 / 255, green: 197 / 255, blue: 76 / 255, alpha: 1)
    let codeBlockColor = NSColor(calibratedWhite: 0.25, alpha: 1)
    let urlColor = NSColor.white
    let visualEffectAppearance = NSAppearance(named: .vibrantDark)!

    fileprivate init() {}
}

struct Themes {
    static let light: ColorTheme = LightTheme()
    static let dark: ColorTheme = DarkTheme()
    static let currentThemeKey: String = "CurrentTheme"
    static var current: ColorTheme = Themes.light {
        didSet {
            DistributedNotificationCenter.default.post(
                name: .ThemeChangedNotification,
                object: self,
                userInfo: [currentThemeKey: Themes.current]
            )
        }
    }
}
