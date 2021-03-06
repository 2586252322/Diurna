//
//  StoriesTableView.swift
//  Diurna
//
//  Created by Nicolas Gaulard-Querol on 22/07/2017.
//  Copyright © 2017 Nicolas Gaulard-Querol. All rights reserved.
//

import Cocoa

class StoriesTableView: NSTableView {

    // MARK: Methods

    override func menu(for event: NSEvent) -> NSMenu? {
        let point = convert(event.locationInWindow, from: nil),
            rowAtPoint = row(at: point)

        guard rowAtPoint != -1 else { return nil }

        let menu = NSMenu(title: "Story Context Menu"),
            item = menu.addItem(withTitle: "Open in browser", action: .openStoryInBrowser, keyEquivalent: "")

        guard
            let cellView = view(atColumn: 0, row: rowAtPoint, makeIfNecessary: false) as? StoryCellView,
            let story = cellView.objectValue as? Story
        else {
            return nil
        }

        item.representedObject = story

        return menu
    }

    @objc func openStoryInBrowser(_ sender: NSMenuItem) {
        guard let story = sender.representedObject as? Story else { return }

        let storyURL = HackerNewsWebpage.item(story.id).path

        do {
            try NSWorkspace.shared.open(storyURL, options: .withoutActivation, configuration: [:])
        } catch let error as NSError {
            NSAlert(error: error).runModal()
        }
    }
}

// MARK: - Selectors

private extension Selector {
    static let openStoryInBrowser = #selector(StoriesTableView.openStoryInBrowser(_:))
}
