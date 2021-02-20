//
//  Variable.swift
//  AlfredWorkflowScriptFilter
//
//  Created by Guillaume Leclerc on 13/02/2021.
//

struct Variable {
    var name: String?
    var value: String?

    static func create(name: String? = nil, value: String? = nil) -> Variable {
        Variable(name: name, value: value)
    }
}
