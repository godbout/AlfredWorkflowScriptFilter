//
//  Icon.swift
//  AlfredWorkflowScriptFilter
//
//  Created by Guillaume Leclerc on 21/02/2021.
//

import Foundation

struct Icon {}

extension Icon: Codable {}

extension Icon: Equatable {
    static func == (_: Icon, _: Icon) -> Bool {
        true
    }
}
