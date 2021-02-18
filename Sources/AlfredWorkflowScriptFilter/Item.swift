//
//  Item.swift
//  AlfredWorkflowScriptFiltah
//
//  Created by Guillaume Leclerc on 13/02/2021.
//

import Foundation

struct Item {}

extension Item: Codable {}

extension Item: Equatable {
    static func == (_: Item, _: Item) -> Bool {
        true
    }
}
