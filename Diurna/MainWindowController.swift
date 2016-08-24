//
//  MainWindowController.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 27/06/2016.
//  Copyright © 2016 Nicolas Gaulard-Querol. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {

    override func windowDidLoad() {
        super.windowDidLoad()

        guard let window = window else { return }

        window.titleVisibility = .hidden
        window.titlebarAppearsTransparent = true
        window.isMovableByWindowBackground = true
        window.backgroundColor = .white

        window.standardWindowButton(NSWindowButton.closeButton)?.frame.origin.y -= 4
        window.standardWindowButton(NSWindowButton.zoomButton)?.frame.origin.y -= 4
        window.standardWindowButton(NSWindowButton.miniaturizeButton)?.frame.origin.y -= 4
    }
}

extension MainWindowController: NSWindowDelegate {
    func windowWillEnterFullScreen(_ notification: Notification) {
        guard notification.name == .NSWindowWillEnterFullScreen else { return }

        NotificationCenter.default.post(name: .enterFullScreenNotification, object: self)
    }

    func windowWillExitFullScreen(_ notification: Notification) {
        guard notification.name == .NSWindowWillExitFullScreen else { return }

        NotificationCenter.default.post(name: .exitFullScreenNotification, object: self)
    }
}

extension Notification.Name {
    static let enterFullScreenNotification = Notification.Name("EnterFullScreenNotification")
    static let exitFullScreenNotification = Notification.Name("ExitFullScreenNotification")
}
