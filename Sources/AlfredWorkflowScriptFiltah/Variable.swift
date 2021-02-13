//
//  Variable.swift
//  AlfredWorkflowScriptFiltah
//
//  Created by Guillaume Leclerc on 13/02/2021.
//

import Foundation

struct Variable {
    private var name: String?
    private var value: String?

    static func create(name: String? = nil, value: String? = nil) -> Variable {
        return Variable(name: name, value: value)
    }
}

extension Variable: Encodable {
}
