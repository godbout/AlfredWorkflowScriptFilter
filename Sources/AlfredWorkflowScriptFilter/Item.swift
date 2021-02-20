//
//  Item.swift
//  AlfredWorkflowScriptFilter
//
//  Created by Guillaume Leclerc on 13/02/2021.
//

import Foundation

struct Item {
    let title: String
    let subtitle: String
    let icon: Icon

    static func create(title: String, subtitle: String, icon: Icon) -> Item {
        Item(title: title, subtitle: subtitle, icon: icon)
    }
}

extension Item: Codable {}

extension Item: Equatable {
    static func == (lhs: Item, rhs: Item) -> Bool {
        lhs.title == rhs.title
            && lhs.subtitle == rhs.subtitle
            && lhs.icon == rhs.icon
    }
}
