//
//  StoryRowView.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 28/01/2017.
//  Copyright © 2017 Nicolas Gaulard-Querol. All rights reserved.
//

import Cocoa

class StoryRowView: NSTableRowView {

    // MARK: Properties

    override var isOpaque: Bool {
        return true
    }

    override var isNextRowSelected: Bool {
        didSet {
            setNeedsDisplay(bounds)
        }
    }

    // MARK: Methods

    override func drawSelection(in dirtyRect: NSRect) {
        guard selectionHighlightStyle != .none else { return }

        Themes.current.cellHighlightBackgroundColor.setFill()
        dirtyRect.fill()
    }

    override func drawSeparator(in _: NSRect) {
        let bottomRect = NSRect(x: 0, y: 0, width: bounds.maxX, height: 1.0),
            topRect = NSRect(x: 0, y: bounds.maxY - 1.0, width: bounds.maxX, height: 1.0)

        Themes.current.dividerColor.setFill()

        if isSelected {
            bottomRect.fill()
        }

        if !isNextRowSelected {
            topRect.fill()
        }
    }
}

// MARK: - NSUserInterfaceItemIdentifier

extension NSUserInterfaceItemIdentifier {
    static let storyRow = NSUserInterfaceItemIdentifier("StoryRow")
}
