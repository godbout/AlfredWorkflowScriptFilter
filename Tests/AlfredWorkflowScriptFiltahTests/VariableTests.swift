//
//  VariableTests.swift
//  AlfredWorkflowScriptFiltahTests
//
//  Created by Guillaume Leclerc on 13/02/2021.
//

import XCTest
@testable import AlfredWorkflowScriptFiltah

class VariableTests: XCTestCase {

    func test_that_a_variable_may_be_empty() {
        let variable = Variable.create()
        var output = ""

        let jsonEncoder = JSONEncoder()
        if let jsonData = try? jsonEncoder.encode(variable) {
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                output = jsonString
            }
        }

        XCTAssertEqual(#"{}"#, output)
    }

    func test_that_a_variable_may_have_a_name_and_a_value() {
        let variable = Variable.create(name: "fruit", value: "tomato")

        XCTAssertEqual(["fruit": "tomato"], variable.toArray())
    }

}
